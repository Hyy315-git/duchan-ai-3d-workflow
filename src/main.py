"""AI + 3D 极简流程：numpy/OpenCV 边缘提取 + trimesh 晶格长方体离屏渲染。"""
import os

import numpy as np
import cv2
import trimesh


def ai_edge():
    """numpy 生成 640x480 测试图案 -> 高斯模糊 + Canny -> output/ai_edge.png"""
    y, x = np.mgrid[:480, :640]
    img = np.uint8(((x // 40 + y // 40) % 2) * 255)        # 棋盘格测试图案
    img[(x - 320) ** 2 + (y - 240) ** 2 < 80 ** 2] = 255   # 叠加圆形
    edges = cv2.Canny(cv2.GaussianBlur(img, (5, 5), 0), 50, 150)
    cv2.imwrite("output/ai_edge.png", edges)


def lattice_3d():
    """trimesh 生成棋盘格晶格长方体（<1000 面）-> 离屏渲染 output/lattice_3d.png"""
    cells = []
    for i in range(6):
        for j in range(3):
            for k in range(2):
                if (i + j + k) % 2 == 0:                    # 交错镂空成晶格
                    b = trimesh.creation.box(extents=[0.04] * 3)
                    b.apply_translation([i * 0.045, j * 0.045, k * 0.045])
                    cells.append(b)
    scene = trimesh.Scene(trimesh.util.concatenate(cells))
    scene.set_camera()                                      # 自动取景
    png = scene.save_image(resolution=[640, 480], visible=False)
    with open("output/lattice_3d.png", "wb") as f:
        f.write(png)


if __name__ == "__main__":
    for d in ("assets", "output"):                          # 目录不存在则自动创建
        os.makedirs(d, exist_ok=True)
    ai_edge()
    lattice_3d()
    print("完成: output/ai_edge.png, output/lattice_3d.png")
