import matplotlib.pyplot as plt
import generalFunctions as gF
from matplotlib.animation import FuncAnimation
from random import sample, shuffle
import numpy as np


# Return the (g,h) index of the BMU in the grid
def find_bmu(som, x):
    distsq = np.asarray([gF.calc_length(x, s) for s in som])
    return np.unravel_index(np.argmin(distsq, axis=None), distsq.shape)


def dist_comp(som, x):
    distsq = []
    for i in range(som.shape[0]):
        for j in range(som.shape[1]):
            distsq.append([(i, j), gF.calc_length(x, som[i][j])])
    return sorted(distsq, key=lambda x: x[1])


# Update the weights of the SOM cells when given a single training example
# and the model parameters along with BMU coordinates as a tuple
def update_weights(som, train_ex, learn_rate, radius_sq,
                   bmu_coord, algorithm, step=1):
    g, h = bmu_coord
    # if radius is close to zero then only BMU is changed
    if radius_sq < 1e-3:
        som[g, h, :] += learn_rate * (train_ex - som[g, h, :])
        return som

    match algorithm:
        case 'kohonen':
            # Change all cells in a small neighborhood of BMU
            for i in range(max(0, g - step), min(som.shape[0], g + step)):
                for j in range(max(0, h - step), min(som.shape[1], h + step)):
                    dist_sq = np.square(i - g) + np.square(j - h)
                    dist_func = np.exp(-dist_sq / 2 / radius_sq)
                    som[i, j, :] += learn_rate * dist_func * (train_ex - som[i, j, :])
        case 'neuron gas':
            dist_rank = dist_comp(som, train_ex)
            for i in range(len(dist_rank)):
                dist_func = np.exp(-i / 2 / np.sqrt(radius_sq))
                som[dist_rank[i][0], dist_rank[i][1], :] += \
                    learn_rate * dist_func * (train_ex - som[dist_rank[i][0], dist_rank[i][1], :])

        case _:
            raise NotImplementedError(
                f'algorithm {algorithm} is not implemented yet')
    return som


# Main routine for training an SOM. It requires an initialized SOM grid
# or a partially trained grid as parameter
def train_som(som, train_data, learn_rate=.1, radius_sq=1,
              lr_decay=.1, radius_decay=.1, epochs=10, algorithm='kohonen'):
    learn_rate_0 = learn_rate
    radius_0 = radius_sq
    for epoch in np.arange(0, epochs):
        shuffle(train_data)
        for train_ex in train_data:
            g, h = find_bmu(som, train_ex)
            som = update_weights(som, train_ex,
                                 learn_rate, radius_sq, (g, h), algorithm)
        # Update learning rate and radius
        learn_rate = learn_rate_0 * np.exp(-epoch * lr_decay)
        radius_sq = radius_0 * np.exp(-epoch * radius_decay)
    return som


def calc_som_error(som, train_data):
    errors = []
    for train_ex in train_data:
        g, h = find_bmu(som, train_ex)
        errors.append(np.sqrt(gF.calc_length(train_ex, som[g][h])))
    return errors


def plot_som(som, train_data, learn_rate=.1, radius_sq=1,
             lr_decay=.1, radius_decay=.1, epochs=10, algorithm='kohonen'):
    fig, ax = plt.subplots()
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_title('Zmiany wag neuronow dla ich roznych ilosci')
    time_text = ax.text(0.05, 0.95, 'iter=2', horizontalalignment='left',
                        verticalalignment='top', transform=ax.transAxes)
    plt.grid(True)
    shapes = [(1, 2), (2, 2), (2, 3), (2, 4), (2, 5), (3, 4), (2, 7), (4, 4), (3, 6), (4, 5)]
    part_som = np.asarray([])
    for i in range(10):
        for j in range(shapes[i][0]*shapes[i][1]):
            np.append(part_som, som[j])



def print_som_stats(som, train_data):
    print('=' * 20)
    print(f'k={len(som)}')
    errs = calc_som_error(som, train_data)
    m = np.mean(errs)
    std = np.std(errs)
    min_err = np.min(errs)
    print("Średni błąd: ", m)
    print("Odchylenie standardowe: ", std)
    print("Błąd minimalny: ", min_err)
