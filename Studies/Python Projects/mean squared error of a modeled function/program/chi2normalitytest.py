#!/usr/bin/env python3

import math
import random

# for stats.chi2.cdf (cumulative chi squared distribution)
from scipy import stats


# X - list, b - begin (first index), e - end (too big index),
# k - index of the element to set in the right place
def quickselect(X, b, e, k):
    # end condition
    if e - b <= 1:
        return
    # random pivot
    r = random.randint(b, e - 1)
    X[b], X[r] = X[r], X[b]
    # partition
    p0 = b
    p1 = b + 1
    while p1 < e:
        if X[p1] < X[p0]:
            if p1 == p0 + 1:
                X[p0], X[p1] = X[p1], X[p0]
                p0 = p1
            else:
                X[p0], X[p0 + 1], X[p1] = X[p1], X[p0], X[p0 + 1]
                p0 += 1
        p1 += 1
    # recursion
    if k < p0:
        quickselect(X, b, p0, k)
    elif k > p0:
        quickselect(X, p0 + 1, e, k)


# quantile calculator (no libraries needed!)
def quantile(X, q, copy=True):
    # edge cases and exceeded range of q
    if q >= 1.0:
        return max(X)
    elif q <= 0.0:
        return min(X)

    n = len(X)
    pos = (n - 1) * q  # target position
    left = int(pos)  # index of the left element
    rcoeff = pos - left  # coefficient for the right element

    # optional copy
    if copy:
        X = X[:]

    quickselect(X, 0, n, left)  # quickselect!

    # X[left] is in order now, and elements on the right are greater
    xleft = X[left]  # left element

    if rcoeff == 0.0:  # the simple case
        return xleft
    else:  # the general case
        xright = min(X[i] for i in range(left + 1, n))  # right element
        return xleft * (1.0 - rcoeff) + xright * rcoeff


# interquantile range
def IQR(X, copy=True):
    if copy:
        X = X[:]
    q1 = quantile(X, 0.25, copy=False)
    q3 = quantile(X, 0.75, copy=False)
    return q3 - q1


# cumulative distribution function of normal distribution N(mu, sigma)
def normal_cdf(mu, sigma, x):
    return 0.5 * (1.0 + math.erf((x - mu) / (2.0 ** 0.5 * sigma)))


# Chi-squared normality test
def chi2normality(X, var_df=1, bins=None):
    n = len(X)
    assert n >= 4
    mu = sum(X) / n  # mean
    evar = sum((x - mu) ** 2 for x in X) / (n - var_df)  # estimated variance
    sigma = evar ** 0.5  # the expected distribution will be N(mu, sigma)

    minx = min(X)
    gap = max(X) - minx
    assert gap != 0.0
    if bins is None:  # guess the number of bins
        # see https://en.wikipedia.org/wiki/Freedman%E2%80%93Diaconis_rule
        h = 2.0 * IQR(X) / (n ** (1.0 / 3.0))  # bin size by the Freedman–Diaconis rule
        k = int(math.ceil(gap / h))  # number of histogram bins
    else:
        k = bins
    k = min(4, k)  # k should be at least 4
    h = gap / k  # actual bin size

    # section points between bins
    points = [minx + h * i for i in range(k + 1)]
    points[0] = -math.inf
    points[-1] = math.inf

    # actual frequency
    freq = [0] * k
    for x in X:
        freq[min(int((x - minx) / h), k - 1)] += 1

    # cumulative distributions for the section points
    cdfs = [normal_cdf(mu, sigma, p) for p in points]

    # expected frequencies
    expected = [(cdfs[i + 1] - cdfs[i]) * n for i in range(k)]

    # Chi-squared statistic
    chi2stat = sum((freq[i] - expected[i]) ** 2 / expected[i] for i in range(k))
    # Chi-squared degrees of freedom
    # i.e. number of bins - 1 - number of parameters of of distribution
    # which is number of bins - 3, as normal distribution has two parameters
    chi2df = k - 3
    # p-value for the "X is sampled from a normal distribution" hypothesis
    # note: for very big chi2stat values, it is close to 0
    pvalue = 1.0 - stats.chi2.cdf(chi2stat, chi2df)

    # significance (alpha) is a probability, that the hypothesis will be rejected
    # despite of being actually true

    # when p-value is lower than alpha, the hypothesis is rejected
    # otherwise, the test fails to reject the hypothesis (this usually happens
    # when the hypothesis is true)

    return pvalue


# perform the test, print some messages
def chi2normality_describe(X, alpha=0.05):
    print('Hypothesis: X is sampled from a normal distribution')
    pvalue = chi2normality(X)
    print('Significance level:', alpha)
    print('p-value: %.7f' % pvalue)
    if pvalue < alpha:
        print('Hypothesis rejected. X doesn\'t seem to be sampled from a normal distribution.')
    else:
        print('Failed to reject the hypothesis.')
    print()


if __name__ == '__main__':
    # test for some uniform distribution
    X = [random.random() * 2.0 + 3.0 for i in range(200)]
    chi2normality_describe(X)

    # test for actual normal distribution
    X = [random.normalvariate(4.0, 5.0) for i in range(200)]
    chi2normality_describe(X)
