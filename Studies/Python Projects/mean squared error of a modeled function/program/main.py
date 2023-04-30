import csv
import matplotlib.pyplot as plt
import numpy as np
import chi2normalitytest as chi

# Funkcje


def csv_data_to_list(file_name):
    file = open(file_name, "r")
    data = list(csv.reader(file, delimiter=','))
    columns = len(data[0])
    file.close()
    if columns == 2:
        return [[float(d[0]), float(d[1])] for d in data]
    else:
        return [[float(d[0]), float(d[1]), float(d[2])] for d in data]


def my_plotter(ax, data_x, data_y, data_z=None, param_dict=None):
    """
    A helper function to make a graph

    Parameters
    ----------
    ax : Axes
        The axes to draw to

    data_x : ndarray
       The x data

    data_y : ndarray
       The y data

    data_z : ndarray
        The z data

    param_dict : dict
       Dictionary of kwargs to pass to ax.plot

    Returns
    -------
    out : list
        list of artists added
    """
    if param_dict is None:
        param_dict = {'marker': 'x', 'linestyle': 'None'}
    if data_z is None:
        out = ax.plot(data_x, data_y, **param_dict)
    else:
        out = ax.scatter3D(data_x, data_y, data_z, **param_dict)
    return out


def approx_by_model(a0, values, *xi):
    size = len(xi[0])
    values = np.reshape(values, (size, 1))
    x = np.reshape(xi[0], (size, 1))
    i = 1
    while i < (len(xi)):
        temp = np.reshape(xi[i], (size, 1))
        x = np.hstack((x, temp))
        i += 1
    if a0:
        x = np.hstack((np.ones((size, 1)), x))

    return np.linalg.inv((x.T @ x)) @ x.T @ values


def f1(a, x):
    return a * x


def f2(a, b, x):
    return a * x + b


def f3(a, b, c, x):
    return a * (x ** 2) + b * np.sin(x) + c


def f4(a, b, c, x1, x2):
    return a * x1 + b * x2 + c


def f5(a, b, c, d, e, f, x1, x2):
    return a * (x1 ** 2) + b * x1 * x2 + c * (x2 ** 2) + d * x1 + e * x2 + f


def max_abs_value(values):
    abs_values = np.abs(values)
    return np.max(abs_values)


def coeff_of_det(err, val):
    return (1 - (np.var(err)/np.var(val))) * 100


def mean_square_error(err):
    return np.sqrt(np.sum((err-np.average(err))**2)/len(err))


# Odczytywanie danych z plików do tablic typu ndarray

data1 = csv_data_to_list("data1.csv")
data1X = np.asarray([d[0] for d in data1])
data1Y = np.asarray([d[1] for d in data1])
data2 = csv_data_to_list("data2.csv")
data2X = np.asarray([d[0] for d in data2])
data2Y = np.asarray([d[1] for d in data2])
data3 = csv_data_to_list("data3.csv")
data3X = np.asarray([d[0] for d in data3])
data3Y = np.asarray([d[1] for d in data3])
data3Z = np.asarray([d[2] for d in data3])
data4 = csv_data_to_list("data4.csv")
data4X = np.asarray([d[0] for d in data4])
data4Y = np.asarray([d[1] for d in data4])
data4Z = np.asarray([d[2] for d in data4])

# Punkty testowe

test_points_data_1 = np.linspace(0, 6, 100)
test_points_data_2 = np.linspace(1.5, 6.5, 100)
test_points_data_3_4_X, test_points_data_3_4_Y = np.meshgrid(np.linspace(0, 5, 100), np.linspace(0, 5, 100))

# Pomocnicze wartości do obliczeń

data1Xsq = data1X * data1X
data2Xsq = data2X * data2X
data1Xsin = np.sin(data1X)
data2Xsin = np.sin(data2X)

# Obliczanie odpowiednich współczynników

# MODEL I
# DANE I
a1 = approx_by_model(False, data1Y, data1X)
# DANE II
a2 = approx_by_model(False, data2Y, data2X)
# MODEL II
# DANE I
a3 = approx_by_model(True, data1Y, data1X)
# DANE II
a4 = approx_by_model(True, data2Y, data2X)
# MODEL III
# DANE I
a5 = approx_by_model(True, data1Y, data1Xsin, data1Xsq)
# DANE II
a6 = approx_by_model(True, data2Y, data2Xsin, data2Xsq)
# MODEL IV
# DANE III
a7 = approx_by_model(True, data3Z, data3Y, data3X)
# DANE IV
a8 = approx_by_model(True, data4Z, data4Y, data4X)
# MODEL V
# DANE III
a9 = approx_by_model(True, data3Z, data3Y, data3X, data3Y * data3Y, data3X * data3Y, data3X * data3X)
# DANE IV
a10 = approx_by_model(True, data4Z, data4Y, data4X, data4Y * data4Y, data4X * data4Y, data4X * data4X)

# Wartości funkcji w punktach testowych oraz w punktach oryginalnych

model1_val1 = f1(a1[0], test_points_data_1)
model1_val1_origin_points = f1(a1[0], data1X)
model1_val2 = f1(a2[0], test_points_data_2)
model1_val2_origin_points = f1(a2[0], data2X)
model2_val1 = f2(a3[1][0], a3[0][0], test_points_data_1)
model2_val1_origin_points = f2(a3[1][0], a3[0][0], data1X)
model2_val2 = f2(a4[1][0], a4[0][0], test_points_data_2)
model2_val2_origin_points = f2(a4[1][0], a4[0][0], data2X)
model3_val1 = f3(a5[2][0], a5[1][0], a5[0][0], test_points_data_1)
model3_val1_origin_points = f3(a5[2][0], a5[1][0], a5[0][0], data1X)
model3_val2 = f3(a6[2][0], a6[1][0], a6[0][0], test_points_data_2)
model3_val2_origin_points = f3(a6[2][0], a6[1][0], a6[0][0], data2X)
model4_val1 = f4(a7[2][0], a7[1][0], a7[0][0], test_points_data_3_4_X, test_points_data_3_4_Y)
model4_val1_origin_points = f4(a7[2][0], a7[1][0], a7[0][0], data3X, data3Y)
model4_val2 = f4(a8[2][0], a8[1][0], a8[0][0], test_points_data_3_4_X, test_points_data_3_4_Y)
model4_val2_origin_points = f4(a8[2][0], a8[1][0], a8[0][0], data4X, data4Y)
model5_val1 = f5(a9[5][0], a9[4][0], a9[3][0], a9[2][0], a9[1][0], a9[0][0], test_points_data_3_4_X,
                 test_points_data_3_4_Y)
model5_val1_origin_points = f5(a9[5][0], a9[4][0], a9[3][0], a9[2][0], a9[1][0], a9[0][0], data3X, data3Y)
model5_val2 = f5(a10[5][0], a10[4][0], a10[3][0], a10[2][0], a10[1][0], a10[0][0], test_points_data_3_4_X,
                 test_points_data_3_4_Y)
model5_val2_origin_points = f5(a10[5][0], a10[4][0], a10[3][0], a10[2][0], a10[1][0], a10[0][0], data4X, data4Y)

# Wartości błędów w punktach oryginalnych

model1_val1_err = data1Y - model1_val1_origin_points
model1_val2_err = data2Y - model1_val2_origin_points
model2_val1_err = data1Y - model2_val1_origin_points
model2_val2_err = data2Y - model2_val2_origin_points
model3_val1_err = data1Y - model3_val1_origin_points
model3_val2_err = data2Y - model3_val2_origin_points
model4_val1_err = data3Z - model4_val1_origin_points
model4_val2_err = data4Z - model4_val2_origin_points
model5_val1_err = data3Z - model5_val1_origin_points
model5_val2_err = data4Z - model5_val2_origin_points

# Sekcja informacji na temat poszczególnych modeli

print("Model 1:  y = ax")
print("Dane 1")
print("a = ", str(a1[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model1_val1_err))
print("Największa wartość odchylenia: ", max_abs_value(model1_val1_err))
print("Współczynnik R**2(%): ", coeff_of_det(model1_val1_err, data1Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model1_val1_err)
print("-----------------------------------")
print("Dane 2")
print("a = ", str(a2[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model1_val2_err))
print("Największa wartość odchylenia: ", max_abs_value(model1_val2_err))
print("Współczynnik R**2(%): ", coeff_of_det(model1_val2_err, data2Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model1_val2_err)
print("-----------------------------------")
print("Model 2: y = ax + b")
print("Dane 1")
print("a = ", str(a3[1][0]), " b = ", str(a3[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model2_val1_err))
print("Największa wartość odchylenia: ", max_abs_value(model2_val1_err))
print("Współczynnik R**2(%): ", coeff_of_det(model2_val1_err, data1Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model2_val1_err)
print("-----------------------------------")
print("Dane 2")
print("a = ", str(a4[1][0]), " b = ", str(a4[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model2_val2_err))
print("Największa wartość odchylenia: ", max_abs_value(model2_val2_err))
print("Współczynnik R**2(%): ", coeff_of_det(model2_val2_err, data2Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model2_val2_err)
print("-----------------------------------")
print("Model 3: y = ax**2 + bsin(x) + c")
print("Dane 1")
print("a = ", str(a5[2][0]), " b = ", str(a5[1][0]), "c = ", str(a5[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model3_val1_err))
print("Największa wartość odchylenia: ", max_abs_value(model3_val1_err))
print("Współczynnik R**2(%): ", coeff_of_det(model3_val1_err, data1Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model3_val1_err)
print("-----------------------------------")
print("Dane 2")
print("a = ", str(a6[2][0]), " b = ", str(a6[1][0]), "c = ", str(a6[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model3_val2_err))
print("Największa wartość odchylenia: ", max_abs_value(model3_val2_err))
print("Współczynnik R**2(%): ", coeff_of_det(model3_val2_err, data2Y))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model3_val2_err)
print("-----------------------------------")
print("Model 4: ax1 + bx2 + c")
print("Dane 3")
print("a = ", str(a7[2][0]), " b = ", str(a7[1][0]), " c = ", str(a7[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model4_val1_err))
print("Największa wartość odchylenia: ", max_abs_value(model4_val1_err))
print("Współczynnik R**2(%): ", coeff_of_det(model4_val1_err, data3Z))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model4_val1_err)
print("-----------------------------------")
print("Dane 4")
print("a = ", str(a8[2][0]), " b = ", str(a8[1][0]), " c = ", str(a8[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model4_val2_err))
print("Największa wartość odchylenia: ", max_abs_value(model4_val2_err))
print("Współczynnik R**2(%): ", coeff_of_det(model4_val2_err, data4Z))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model4_val2_err)
print("-----------------------------------")
print("Model 5: ax1**2 + bx1x2 + cx2**2 + dx1 + ex2 + f")
print("Dane 3")
print("a = ", str(a9[5][0]), " b = ", str(a9[4][0]), " c = ",
      str(a9[3][0]), "d = ", str(a9[2][0]), "e = ", str(a9[1][0]), "f = ", str(a9[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model5_val1_err))
print("Największa wartość odchylenia: ", max_abs_value(model5_val1_err))
print("Współczynnik R**2(%): ", coeff_of_det(model5_val1_err, data3Z))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model5_val1_err)
print("-----------------------------------")
print("Dane 4")
print("a = ", str(a10[5][0]), " b = ", str(a10[4][0]), " c = ",
      str(a10[3][0]), "d = ", str(a10[2][0]), "e = ", str(a10[1][0]), "f = ", str(a10[0][0]))
print("Średni błąd kwadratowy: ", mean_square_error(model5_val2_err))
print("Największa wartość odchylenia: ", max_abs_value(model5_val2_err))
print("Współczynnik R**2(%): ", coeff_of_det(model5_val2_err, data4Z))
print("Test chi kwadrat: ")
print("-----------------------------------")
chi.chi2normality_describe(model5_val2_err)
print("-----------------------------------")

# Sekcja wykresów

fig1, (ax1_1, ax1_2) = plt.subplots(1, 2)
plt.suptitle("Aproksymacja za pomocą funkcji y = ax")
my_plotter(ax1_1, data1X, data1Y)
my_plotter(ax1_1, test_points_data_1, model1_val1, None, {'marker': '', 'linestyle': 'solid'})
my_plotter(ax1_2, data2X, data2Y)
my_plotter(ax1_2, test_points_data_2, model1_val2, None, {'marker': '', 'linestyle': 'solid'})
ax1_1.title.set_text("Dane 1")
ax1_2.title.set_text("Dane 2")

plt.show()

fig2, (ax2_1, ax2_2) = plt.subplots(1, 2)
plt.suptitle("Histogramy odchyleń dla modelu 1")
ax2_1.title.set_text("Dane 1")
ax2_1.hist(model1_val1_err, bins=10)
ax2_2.title.set_text("Dane 2")
ax2_2.hist(model1_val2_err, bins=10)

plt.show()

fig3, (ax3_1, ax3_2) = plt.subplots(1, 2)
plt.suptitle("Aproksymacja za pomocą funkcji y = ax + b")
my_plotter(ax3_1, data1X, data1Y)
my_plotter(ax3_1, test_points_data_1, model2_val1, None, {'marker': '', 'linestyle': 'solid'})
my_plotter(ax3_2, data2X, data2Y)
my_plotter(ax3_2, test_points_data_2, model2_val2, None, {'marker': '', 'linestyle': 'solid'})
ax3_1.title.set_text("Dane 1")
ax3_2.title.set_text("Dane 2")

plt.show()

fig4, (ax4_1, ax4_2) = plt.subplots(1, 2)
plt.suptitle("Histogramy odchyleń dla modelu 2")
ax4_1.title.set_text("Dane 1")
ax4_1.hist(model2_val1_err, bins=10)
ax4_2.title.set_text("Dane 2")
ax4_2.hist(model2_val2_err, bins=10)

plt.show()

fig5, (ax5_1, ax5_2) = plt.subplots(1, 2)
plt.suptitle("Aproksymacja za pomocą funkcji y = ax**2+bsin(x)+c")
my_plotter(ax5_1, data1X, data1Y)
my_plotter(ax5_1, test_points_data_1, model3_val1, None, {'marker': '', 'linestyle': 'solid'})
my_plotter(ax5_2, data2X, data2Y)
my_plotter(ax5_2, test_points_data_2, model3_val2, None, {'marker': '', 'linestyle': 'solid'})
ax5_1.title.set_text("Dane 1")
ax5_2.title.set_text("Dane 2")

plt.show()

fig6, (ax6_1, ax6_2) = plt.subplots(1, 2)
plt.suptitle("Histogramy odchyleń dla modelu 3")
ax6_1.title.set_text("Dane 1")
ax6_1.hist(model3_val1_err, bins=10)
ax6_2.title.set_text("Dane 2")
ax6_2.hist(model3_val2_err, bins=10)

plt.show()

fig7 = plt.figure()
plt.suptitle("Aproksymacja za pomocą funkcji y = ax1+bx2+c")
ax7 = fig7.add_subplot(1, 2, 1, projection='3d')
ax7.title.set_text("Dane 3")
my_plotter(ax7, data3X, data3Y, data3Z, {'cmap': 'cividis'})
ax7.contour3D(test_points_data_3_4_X, test_points_data_3_4_Y, model4_val1, 50, cmap='binary')
ax7 = fig7.add_subplot(1, 2, 2, projection='3d')
ax7.title.set_text("Dane 4")
my_plotter(ax7, data4X, data4Y, data4Z, {'cmap': 'cividis'})
ax7.contour3D(test_points_data_3_4_X, test_points_data_3_4_Y, model4_val2, 50, cmap='binary')

plt.show()

fig8, (ax8_1, ax8_2) = plt.subplots(1, 2)
plt.suptitle("Histogramy odchyleń dla modelu 4")
ax8_1.title.set_text("Dane 3")
ax8_1.hist(model4_val1_err, bins=10)
ax8_2.title.set_text("Dane 4")
ax8_2.hist(model4_val2_err, bins=10)

plt.show()

fig9 = plt.figure()
plt.suptitle("Aproksymacja za pomocą funkcji y = ax1**2+bx1x2+cx2**2+dx1+ex2+f")
ax9 = fig9.add_subplot(1, 2, 1, projection='3d')
ax9.title.set_text("Dane 3")
my_plotter(ax9, data3X, data3Y, data3Z, {'cmap': 'cividis'})
ax9.contour3D(test_points_data_3_4_X, test_points_data_3_4_Y, model5_val1, 50,  cmap='binary')
ax9 = fig9.add_subplot(1, 2, 2, projection='3d')
ax9.title.set_text("Dane 4")
my_plotter(ax9, data4X, data4Y, data4Z, {'cmap': 'cividis'})
ax9.contour3D(test_points_data_3_4_X, test_points_data_3_4_Y, model5_val2, 50,  cmap='binary')

plt.show()

fig10, (ax10_1, ax10_2) = plt.subplots(1, 2)
plt.suptitle("Histogramy odchyleń dla modelu 5")
ax10_1.title.set_text("Dane 3")
ax10_1.hist(model5_val1_err, bins=10)
ax10_2.title.set_text("Dane 4")
ax10_2.hist(model5_val2_err, bins=10)

plt.show()
