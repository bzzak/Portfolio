import matplotlib.pyplot as plt
from random import sample, shuffle
import numpy as np


def get_color(i):
    return plt.get_cmap('tab20')(i)


def calc_length(a, b):
    # return ((b[0]-a[0])**2+(b[1]-a[1])**2)**0.5
    # no need to calculate square root for comparison
    return (b[0] - a[0]) ** 2 + (b[1] - a[1]) ** 2


def plot_data(data):
    lst_x, lst_y = zip(*data)
    lst_x = list(lst_x)
    lst_y = list(lst_y)
    plt.figure(1)
    ax = plt.axes()
    ax.scatter(lst_x, lst_y)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    plt.grid(True)
    plt.show()


def init_units(data, k, method='forgy'):  # TODO: Add k-units++ and Random Partition
    match method:
        case 'forgy':
            return sample(data, k)
        case 'random_partition':
            shuffled = list(data)
            shuffle(shuffled)
            div = len(shuffled) / k
            partition = [shuffled[int(round(div * i)):int(round(div * (i + 1)))] for i in range(k)]
            return [np.mean(prt, axis=0) for prt in partition]
        case _:
            raise NotImplementedError(
                f'method {method} is not implemented yet')