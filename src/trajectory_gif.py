import imageio.v2 as imageio
from PIL import Image
import numpy as np
import os

pngs_path = '/Users/yinzheming/Downloads/FA/new_gif/'
png_names = sorted(os.listdir(pngs_path))







cfar_empty_names = []
rdmV_empty_names = []


for png_name in png_names:
    if png_name[-3:] == 'png':
        if png_name[-5:-4] == 'c':
            cfar_empty_names.append(png_name)
        elif png_name[-5:-4] == 'r':
            rdmV_empty_names.append(png_name)

# cfar_names.sort(key=lambda x: x[-6:-4], reverse=False)
print(cfar_empty_names)

cfar_empty_path = os.path.join(pngs_path, 'cfar_empty.gif')
with imageio.get_writer(uri=cfar_empty_path, mode='I', fps=2) as writer:
    for i in range(len(cfar_empty_names)):
        png_path = os.path.join(pngs_path, cfar_empty_names[i])
        writer.append_data(imageio.imread(png_path))

rdmV_empty_path = os.path.join(pngs_path, 'rdmV_empty.gif')
with imageio.get_writer(uri=rdmV_empty_path, mode='I', fps=2) as writer:
    for i in range(len(rdmV_empty_names)):
        png_path = os.path.join(pngs_path, rdmV_empty_names[i])
        writer.append_data(imageio.imread(png_path))















# cfar_names = []
# cfar_empty_names = []
# rdmV_names = []
# rdmV_empty_names = []
# rdmW_names = []
# rdmW_empty_names = []
#
#
# for png_name in png_names:
#     if png_name[-3:] == 'png':
#         if png_name[:4] == 'cfar':
#             if png_name[5:10] == 'empty':
#                 cfar_empty_names.append(png_name)
#             else:
#                 cfar_names.append(png_name)
#         elif png_name[:4] == 'rdmV':
#             if png_name[5:10] == 'empty':
#                 rdmV_empty_names.append(png_name)
#             else:
#                 rdmV_names.append(png_name)
#         elif png_name[:4] == 'rdmW':
#             if png_name[5:10] == 'empty':
#                 rdmW_empty_names.append(png_name)
#             else:
#                 rdmW_names.append(png_name)
#
# # cfar_names.sort(key=lambda x: x[-6:-4], reverse=False)
# print(cfar_names)
#
# cfar_path = os.path.join(pngs_path, 'cfar.gif')
# with imageio.get_writer(uri=cfar_path, mode='I', fps=1) as writer:
#     for i in range(len(cfar_names)):
#         png_path = os.path.join(pngs_path, cfar_names[i])
#         writer.append_data(imageio.imread(png_path))
#
# rdmV_path = os.path.join(pngs_path, 'rdmV.gif')
# with imageio.get_writer(uri=rdmV_path, mode='I', fps=1) as writer:
#     for i in range(len(rdmV_names)):
#         png_path = os.path.join(pngs_path, rdmV_names[i])
#         writer.append_data(imageio.imread(png_path))
#
# rdmW_path = os.path.join(pngs_path, 'rdmW.gif')
# with imageio.get_writer(uri=rdmW_path, mode='I', fps=1) as writer:
#     for i in range(len(rdmW_names)):
#         png_path = os.path.join(pngs_path, rdmW_names[i])
#         writer.append_data(imageio.imread(png_path))
#
# cfar_empty_path = os.path.join(pngs_path, 'cfar_empty.gif')
# with imageio.get_writer(uri=cfar_empty_path, mode='I', fps=1) as writer:
#     for i in range(len(cfar_empty_names)):
#         png_path = os.path.join(pngs_path, cfar_empty_names[i])
#         writer.append_data(imageio.imread(png_path))
#
# rdmV_empty_path = os.path.join(pngs_path, 'rdmV_empty.gif')
# with imageio.get_writer(uri=rdmV_empty_path, mode='I', fps=1) as writer:
#     for i in range(len(rdmV_empty_names)):
#         png_path = os.path.join(pngs_path, rdmV_empty_names[i])
#         writer.append_data(imageio.imread(png_path))
#
# rdmW_empty_path = os.path.join(pngs_path, 'rdmW_empty.gif')
# with imageio.get_writer(uri=rdmW_empty_path, mode='I', fps=1) as writer:
#     for i in range(len(rdmW_empty_names)):
#         png_path = os.path.join(pngs_path, rdmW_empty_names[i])
#         writer.append_data(imageio.imread(png_path))