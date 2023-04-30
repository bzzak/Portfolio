import kmeans as km
import generalFunctions as gF
from generate_points import get_random_point
import numpy as np
import json

METHODS = ['forgy', 'random_partition']


def get_data1():
    data = []
    for _ in range(200):
        data.append(get_random_point((0, 0), 1))
    return data


def get_data2():
    data = []
    for i in range(2):
        for _ in range(100):
            data.append(get_random_point((3 * ((-1) ** i), 0), 0.5))
    return data


def main(datas):
    # for get_data in [get_data1, get_data2]:
    #    data = get_data()
    indeks = 1
    for data in datas:
        gF.plot_data(data)
        for method in METHODS:
            kmeans_data = {}
            for k in [20]:  # range(2, 21):
                kmeans_with_err = []
                for _ in range(100):
                    centroids_with_clusters = []
                    centroids = gF.init_units(data, k, method=method)
                    clusters = {}
                    for i in range(k):
                        clusters[i] = []
                    for point in data:
                        lengths = [gF.calc_length(c, point) for c in centroids]
                        index_min = int(np.argmin(lengths))
                        clusters[index_min].append(point)
                    centroids_with_clusters.append((list(centroids), clusters))
                    for _ in range(100):
                        for key in clusters:
                            if clusters[key]:
                                centroids[key] = np.mean(clusters[key], axis=0)
                        clusters = {}
                        for i in range(k):
                            clusters[i] = []
                        for point in data:
                            lengths = [gF.calc_length(c, point)
                                       for c in centroids]
                            index_min = int(np.argmin(lengths))
                            clusters[index_min].append(point)
                        centroids_with_clusters.append(
                            (list(centroids), clusters))
                        if all([all(np.isclose(centroids_with_clusters[-1][0][i], centroids_with_clusters[-2][0][i]))
                                for i in range(k)]):
                            break
                    err = km.calc_error(centroids, clusters, k)
                    kmeans_with_err.append((centroids_with_clusters, err))
                km.print_stats(k, [(iterations[-1], err) for iterations, err in kmeans_with_err])
                min_err = kmeans_with_err[0][1]
                kmeans = kmeans_with_err[0][0]
                for temp_kmeans, err in kmeans_with_err:
                    if err < min_err:
                        min_err = err
                        kmeans = temp_kmeans
                kmeans_data[k] = (kmeans, min_err)
                km.plot_kmeans(kmeans, k, indeks)
                indeks += 1
            # error_data = [[i, kmeans_data[i][1]] for i in range(2, 21, 2)]
            # plot_error_data(error_data)


if __name__ == '__main__':
    datas = []
    with open('data1.json', 'r') as d:
        datas.append(json.loads(d.read()))
    with open('data2.json', 'r') as d:
        datas.append(json.loads(d.read()))
    main(datas)
