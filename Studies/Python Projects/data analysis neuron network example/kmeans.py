import matplotlib.pyplot as plt
import generalFunctions as gF
from matplotlib.animation import FuncAnimation
import numpy as np


def plot_kmeans(all_data, k, i):
    fig, ax = plt.subplots()
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_title(f'k={k}')
    time_text = ax.text(0.05, 0.95, 'iter=0', horizontalalignment='left',
                        verticalalignment='top', transform=ax.transAxes)
    plt.grid(True)
    centroid_scatters = []
    cluster_scatters = {}
    centroids, clusters = all_data[0]
    for key in clusters:
        color = gF.get_color(key / k)
        if clusters[key]:
            lst_x, lst_y = zip(*clusters[key])
            lst_x = list(lst_x)
            lst_y = list(lst_y)
            cluster_scatters[key] = ax.scatter(lst_x, lst_y, color=color)
        centroid_scatters.append(ax.scatter([centroids[key][0]], [
            centroids[key][1]], color=color, marker='X'))

    def update_plot_kmeans(i):
        centroids, clusters = all_data[i]
        time_text.set_text(f'iter={i}')
        for key in clusters:
            centroid_scatters[key].set_offsets(centroids[key])
            if clusters[key]:
                if key in cluster_scatters:
                    cluster_scatters[key].set_offsets(clusters[key])
                else:
                    color = gF.get_color(key/k)
                    lst_x, lst_y = zip(*clusters[key])
                    lst_x = list(lst_x)
                    lst_y = list(lst_y)
                    cluster_scatters[key] = ax.scatter(lst_x, lst_y, color=color)
        return centroid_scatters + list(cluster_scatters.values()) + [time_text, ]

    anim = FuncAnimation(fig, update_plot_kmeans,
                         frames=len(all_data), blit=True)
    anim.save(f'animationKMEANS{i}.gif')

    plt.show()


def calc_error(centroids, clusters, k):
    squared_errors = []
    for i in range(k):
        cluster = np.array(clusters[i])
        centroid = np.array([centroids[i] for _ in range(len(cluster))])
        errors = cluster - centroid
        squared_errors.append([e ** 2 for e in errors])
    return sum([np.mean(err) if err else 0 for err in squared_errors])


def plot_error_data(error_data):
    fig, ax = plt.subplots()
    ax.set_xlabel('k')
    ax.set_ylabel('err')
    ax.set_xlim(2, 20)
    plt.title('Errors')
    plt.grid(True)

    lst_x, lst_y = zip(*error_data)
    lst_x = list(lst_x)
    lst_y = list(lst_y)
    ax.plot(lst_x, lst_y, 'ro-')

    plt.show()


def print_stats(k, data):
    print('=' * 20)
    print(f'k={k}')
    errs = [x[1] for x in data]
    m = np.mean(errs)
    std = np.std(errs)
    min_err = np.min(errs)
    lst_empty = [sum([1 for cluster in centroids_with_clusters[1] if not cluster]) for centroids_with_clusters, _ in
                 data]
    print(lst_empty)
    print("Średni błąd: ", m)
    print("Odchylenie standardowe: ", std)
    print("Błąd minimalny: ", min_err)

