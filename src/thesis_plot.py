# Convert the thesis_plot.m into the language in Python

import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import chirp
from matplotlib import font_manager

# # FMCW_signal_left
# Fs = 10000
# T = 1
# f0 = 10
# f1 = 500
# t = np.linspace(0, T, Fs * T)
#
# y = chirp(t, f0, T, f1)
#
# plt.figure()
# plt.plot(t, y)
# plt.xlim([0, 0.5])
# plt.ylim([-1.5, 1.5])
# # plt.text(0.5, -1.7, 't', ha='center', fontsize=20)
# # plt.text(-0.009, 1.35, 'A', fontsize=20, rotation=0, va='bottom', ha='right')
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()







# # FMCW_signal_right
# T_r = 280
# T_c = 200
# f_c = 300
# B = 400
# t = np.arange(0, T_c, 0.01)
#
# f_tx = 2 * t + f_c
# t1 = np.arange(T_r, T_r+T_c, 0.01)
# t2 = np.arange(T_r*2, T_r*2+T_c, 0.01)
# # t3 = np.arange(T_r, T_r*3+T_c, 0.01)
#
# f_rx1 = 2 * (t1 - T_r) + f_c
# f_rx2 = 2 * (t2 - T_r * 2) + f_c
# # f_rx3 = 0.05 * (t3 + T_r * 3) + f_c
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=14)
# plt.plot(t, f_tx, '#2878B5', linewidth=2, label='chirp 1')
# plt.plot(t1, f_rx1, '#9AC9DB', linewidth=2, label='chirp 2')
# plt.plot(t2, f_rx2, '#F8AC8C', linewidth=2, label='chirp 3')
# # plt.plot(t3, f_rx3, 'b', linewidth=2, label='Receive signal 3')
#
# plt.xlim([-100, 1200])
# plt.ylim([0, 1000])
#
# # plt.plot([-100, 0], [f_c, f_c], 'k--')
# # plt.plot([-100, 100], [f_c+B/2, f_c+B/2], 'k--')
# # plt.plot([-100, 200], [f_c+B, f_c+B], 'k--')
# # plt.plot([0, 0], [0, f_c], 'k--')
# # plt.plot([100, 100], [0, f_c+B/2], 'k--')
# # plt.plot([200, 200], [0, f_c+B], 'k--')
#
# # plt.text(-120, f_c-15, r'$f_c$', ha='right', fontsize=18)
# # plt.text(-120, f_c+B/2-15, r'$f_c+\frac{B}{2}$', ha='right', fontsize=18, fontdict={'family':'Times New Roman'})
# # plt.text(-120, f_c+B-15, r'$f_c+B$', ha='right', fontsize=18, fontdict={'family':'Times New Roman'})
# # plt.text(0, -60, '0', ha='center', fontsize=18, fontdict={'family':'Times New Roman'})
# # plt.text(100, -80, r'$\frac{T_c}{2}$', ha='center', fontsize=18, fontdict={'family':'Times New Roman'})
# # plt.text(200, -60, r'$T_c$', ha='center', fontsize=18, fontdict={'family':'Times New Roman'})
# # plt.text(750, 520, '.', ha='center', fontsize=25, fontdict={'family':'Times New Roman'})
# # plt.text(780, 520, '.', ha='center', fontsize=25, fontdict={'family':'Times New Roman'})
# # plt.text(810, 520, '.', ha='center', fontsize=25, fontdict={'family':'Times New Roman'})
# # plt.text(990, -60, 't', ha='center', fontsize=18)
# # plt.text(-120, 950, 'f', fontsize=18, rotation=0, va='bottom', ha='right')
#
# plt.legend(prop=font_properties)
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()









# # FMCW signal_right
# T = 1
# Fs = 1000
# t = np.arange(0, 3 * T, 1 / Fs)
#
# f = (t % T) * (500 / T) + 100
#
# plt.figure()
# plt.plot(t, f)
# # plt.xlabel('t', fontsize=20)
# # plt.ylabel('f', fontsize=20, rotation=0, verticalalignment='bottom', horizontalalignment='right')
# plt.xlim([0, 4])
# plt.ylim([0, 700])
# plt.text(4, -50, 't', ha='center', fontsize=20)
# plt.text(-0.1, 680, 'f', fontsize=20, rotation=0, va='bottom', ha='right')
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()




# # IF_signal_left
# t = np.arange(0, 7, 0.01)
# f_tx = 2 * t
# t1 = np.arange(3, 10, 0.01)
# t2 = np.arange(4, 11, 0.01)
# t3 = np.arange(5, 12, 0.01)
#
# delay1 = -3
# delay2 = -4
# delay3 = -5
#
# f_rx1 = 2 * (t1 + delay1)
# f_rx2 = 2 * (t2 + delay2)
# f_rx3 = 2 * (t3 + delay3)
#
# tau = 3
# Tc = 7
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
# plt.plot(t, f_tx, '#999999', linewidth=2, label='TX')
# plt.plot(t1, f_rx1, '#2878B5', linewidth=2, label='Receive signal 1')
# plt.plot(t2, f_rx2, '#9AC9DB', linewidth=2, label='Receive signal 2')
# plt.plot(t3, f_rx3, '#F8AC8C', linewidth=2, label='Receive signal 3')
#
# # plt.plot([tau, tau], [0, 2 * tau], 'k--')
# # plt.plot([0, tau], [2 * tau, 2 * tau], 'k--')
# # plt.plot([Tc, Tc], [0, 2 * Tc], 'k--')
# # plt.plot([0, Tc], [2 * Tc, 2 * Tc], 'k--')
# #
# # plt.text(tau, -1.2, r'$\tau$', ha='center', fontsize=20)
# # plt.text(Tc, -1.25, 'Tc', ha='center', fontsize=20)
# # plt.text(-0.2, 2 * tau - 1, r'S$\tau$', fontsize=20, rotation=0, va='bottom', ha='right')
# # plt.text(-0.2, 2 * Tc-1, 'B', fontsize=20, rotation=0, va='bottom', ha='right')
# # plt.text(15, -1.25, 't', ha='center', fontsize=20)
# # plt.text(-0.2, 19, 'f', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.xlim([0, 15])
# plt.ylim([0, 20])
#
# plt.legend(prop=font_properties)
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()






# IF_signal_right
f1 = 2
f2 = 3
f3 = 4

start_time = 3
end_time = 8

plt.figure()
font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
plt.plot([start_time, end_time], [f1, f1], '#2878B5', linewidth=2, label='IF signal 1')
plt.plot([start_time+1, end_time+1], [f2, f2], '#9AC9DB', linewidth=2, label='IF signal 2')
plt.plot([start_time+2, end_time+2], [f3, f3], '#F8AC8C', linewidth=2, label='IF signal 3')

# plt.plot([start_time, start_time], [0, 10], 'k--')
# plt.plot([end_time, end_time], [0, 10], 'k--')
# plt.plot([0, start_time], [f1, f1], 'k--')
#
# plt.text(start_time, -0.5, r'$\tau$', ha='center', fontsize=20)
# plt.text(-0.3, f1-0.3, r'S$\tau$', fontsize=20, rotation=0, va='bottom', ha='right')
# plt.text(10, -0.5, 't', ha='center', fontsize=20)
# plt.text(-0.3, 7.6, 'f', fontsize=20, rotation=0, va='bottom', ha='right')

plt.xlim([0, 10])
plt.ylim([0, 8])

plt.legend(prop=font_properties)
plt.gca().set_xticks([])
plt.gca().set_yticks([])
plt.grid(True)
plt.show()







# # range_resolution_21
# t = np.arange(0, 3, 0.01)
#
# A = 1
# f1 = 4
# f2 = 4.07
# phi = np.pi / 20
#
# signal1 = A * np.sin(f1 * t)
# signal2 = A * np.sin(f2 * t + phi)
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
# plt.plot(t, signal1, '#9AC9DB', linewidth=2, label='IF signal 1')
# plt.plot(t, signal2, '#F8AC8C', linewidth=2, label='IF signal 2')
#
# # plt.plot([0, 0], [-1.5, 1.5], 'k--')
# # plt.plot([3, 3], [-1.5, 1.5], 'k--')
#
# plt.xlim([-2, 8])
# plt.ylim([-1.5, 1.5])
# # plt.text(8, -1.7, 't', ha='center', fontsize=20)
# # plt.text(-2.2, 1.4, 'A', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.legend(prop=font_properties)
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()




# # range_resolution_22
# t = np.arange(0, 6, 0.01)
#
# A = 1
# f1 = 4
# f2 = 4.09
# phi = np.pi / 20
#
# signal1 = A * np.sin(f1 * t)
# signal2 = A * np.sin(f2 * t + phi)
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
# plt.plot(t, signal1, '#9AC9DB', linewidth=2, label='IF signal 1')
# plt.plot(t, signal2, '#F8AC8C', linewidth=2, label='IF signal 2')
#
# # plt.plot([0, 0], [-1.5, 1.5], 'k--')
# # plt.plot([6, 6], [-1.5, 1.5], 'k--')
#
# plt.xlim([-2, 8])
# plt.ylim([-1.5, 1.5])
# # plt.text(8, -1.7, 't', ha='center', fontsize=20)
# # plt.text(-2.2, 1.4, 'A', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.legend(prop=font_properties)
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()





# # range_resolution_11
# t = np.arange(-2, 3, 0.01)
# f_tx = t
# t1 = np.arange(0, 5, 0.01)
# t2 = np.arange(1, 6, 0.01)
# t3 = np.arange(2, 7, 0.01)
#
# delay1 = -2
# delay2 = -3
# delay3 = -4
#
# f_rx1 = t1 + delay1
# f_rx2 = t2 + delay2
# f_rx3 = t3 + delay3
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
# plt.plot(t, f_tx, '#999999', linewidth=2, label='TX chirp')
# plt.plot(t1, f_rx1, '#9AC9DB', linewidth=2, label='IF signal 1')
# plt.plot(t2, f_rx2, '#F8AC8C', linewidth=2, label='IF signal 2')
#
# # plt.plot([-2, 3], [3, 3], 'k--')
# # plt.plot([0, 0], [-2, 3], 'k--')
# # plt.plot([3, 3], [-2, 3], 'k--')
# #
# # plt.text(-2.1, 2.7, 'B', fontsize=20, rotation=0, va='bottom', ha='right')
# # plt.text(7.9, -2.7, 't', ha='center', fontsize=20)
# # plt.text(-2.1, 7.7, 'f', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.xlim([-2, 8])
# plt.ylim([-2, 8])
#
# plt.legend(prop=font_properties)
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()






# # range_resolution_12
# t = np.arange(-2, 6, 0.01)
# f_tx = t
# t1 = np.arange(0, 8, 0.01)
# t2 = np.arange(1, 9, 0.01)
# t3 = np.arange(2, 10, 0.01)
#
# delay1 = -2
# delay2 = -3
# delay3 = -4
#
# f_rx1 = t1 + delay1
# f_rx2 = t2 + delay2
# f_rx3 = t3 + delay3
#
# plt.figure()
# font_properties = font_manager.FontProperties(family='Times New Roman', size=12)
# plt.plot(t, f_tx, '#999999', linewidth=2, label='TX chirp')
# plt.plot(t1, f_rx1, '#9AC9DB', linewidth=2, label='IF signal 1')
# plt.plot(t2, f_rx2, '#F8AC8C', linewidth=2, label='IF signal 2')
#
# # plt.plot([-2, 6], [6, 6], 'k--')
# # plt.plot([0, 0], [-2, 6], 'k--')
# # plt.plot([6, 6], [-2, 6], 'k--')
# #
# # plt.text(-2.1, 5.7, '2B', fontsize=20, rotation=0, va='bottom', ha='right')
# # plt.text(7.9, -2.7, 't', ha='center', fontsize=20)
# # plt.text(-2.1, 7.7, 'f', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.xlim([-2, 8])
# plt.ylim([-2, 8])
#
# plt.legend(prop=font_properties, loc='lower right')
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()






# # range_resolution_31
# f = np.linspace(-2000, 2000, 1000)
# y = np.exp(-0.00001 * ((f+600) ** 2))
#
# jitter = 0.01 * np.random.randn(len(f))
# y_jitter = y + jitter
#
# plt.figure()
# plt.plot(f, y_jitter, '#999999')
#
# plt.xlim([-2000, 2000])
# plt.ylim([0, 1.1])
# # plt.text(2000, -0.08, 'f', ha='center', fontsize=20)
# # plt.text(-2020, 1.05, 'A', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()





# # range_resolution_32
# f = np.linspace(-2000, 2000, 1000)
# y1 = np.exp(-0.00001 * ((f - 500) ** 2))
# y2 = np.exp(-0.00001 * ((f + 500) ** 2))
# y = y1 + y2
#
# jitter = 0.02 * np.random.randn(len(f))
# y_jitter = y + jitter
#
# plt.figure()
# plt.plot(f, y_jitter, '#999999')
#
# plt.xlim([-2500, 2500])
# plt.ylim([-0.2, 1.2])
#
# # plt.text(2500, -0.3, 'f', ha='center', fontsize=20)
# # plt.text(-2520, 1.15, 'A', fontsize=20, rotation=0, va='bottom', ha='right')
#
# plt.gca().set_xticks([])
# plt.gca().set_yticks([])
# plt.grid(True)
# plt.show()









# fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')
#
# # Define the vectors
# r = np.array([1, 1, 1])
# r_proj = np.array([1, 1, 0])
# origin = np.array([0, 0, 0])
#
# # Plot the vectors
# ax.quiver(*origin, *r, color='g', label='r')
# ax.quiver(*origin, *r_proj, color='k', linestyle='dotted', label='r_proj')
#
# # Draw the projection on the XY plane
# ax.plot([r[0], r[0]], [r[1], r[1]], [0, r[2]], 'k--')
#
# # Set labels and limits
# ax.set_xlabel('x')
# ax.set_ylabel('y')
# ax.set_zlabel('z')
# ax.set_xlim([0, 1.5])
# ax.set_ylim([0, 1.5])
# ax.set_zlim([0, 1.5])
#
# # Annotate the angles
# ax.text(0.5, 0.5, 0, 'az', fontsize=12)
# ax.text(r[0], r[1], r[2]/2, 'el', fontsize=12)
#
# # Add the azimuth and elevation angle annotations
# ax.text(r[0]/2, r[1]/2, 0, r'$\mathrm{r_{proj}}$', fontsize=12)
# ax.text(r[0]/2, r[1]/2, r[2]/2, r'$\mathrm{r}$', fontsize=12)
#
# plt.legend()
# plt.show()

