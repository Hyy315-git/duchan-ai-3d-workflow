# AI + 3D 极简流程（鞋型晶格结构）

一个极简、可运行、跨平台的 **AI + 3D** 演示项目，贴合「鞋型晶格结构」主题：

- **AI 部分**：程序内部用 numpy 直接生成 640×480 测试图案（不读外部图片），OpenCV 做高斯模糊 + Canny 边缘提取，结果保存到 `output/ai_edge.png`。
- **3D 部分**：用 trimesh 生成简化的棋盘格晶格长方体（模拟鞋型晶格结构，总面数 < 1000），**强制离屏渲染**（绝不弹窗）640×480 预览图到 `output/lattice_3d.png`。

全程无外部图片输入、无交互窗口，兼容 **Windows / macOS**（含无 GUI 环境）。

## 设计原则

极简、短代码、可运行、跨平台，禁止过度设计：无复杂曲面、无交互窗口、全相对路径、目录自动创建、统一主入口。

## 目录结构

```
.
├── src/
│   ├── __init__.py                # 包标识
│   └── main.py                    # 项目代码（AI + 3D，统一入口）
├── assets/                        # 示例资源目录（预留，本流程无需外部资源）
├── output/                        # 运行结果（ai_edge.png / lattice_3d.png，git 忽略）
├── docs/
│   └── reproduction-checklist.md  # 跨平台复现自检清单
├── requirements.txt               # 精确锁定版本的依赖清单
├── install.bat                    # Windows 一键安装脚本
├── install.sh                     # macOS 一键安装脚本
├── run.bat                        # Windows 一键启动脚本
├── run.sh                         # macOS 一键启动脚本
├── .gitignore
└── README.md
```

## 前置依赖

| 依赖 | 版本要求 | 说明 |
| --- | --- | --- |
| Python | **3.12（推荐，已实测）** | 3.10+ 通常可用，但 scipy 新版本建议 ≥ 3.11 |
| Git | 任意较新版本 | 用于克隆仓库 |
| 依赖包 | 见 `requirements.txt` | 精确锁定版本，Windows / macOS 通用 |

> 依赖已包含 `pyglet<2` 与 `scipy`：二者是 trimesh 4.4.9 离屏渲染的必要组件，缺一不可。

### 依赖清单（全部精确锁定版本）

| 包 | 版本 | 用途 |
| --- | --- | --- |
| numpy | 2.0.2 | 生成测试图案 |
| opencv-python | 4.10.0.84 | 高斯模糊 + Canny 边缘提取 |
| trimesh | 4.4.9 | 3D 网格生成与离屏渲染 |
| pyglet | 1.5.31 | trimesh 离屏渲染后端（要求 <2） |
| scipy | 1.18.1 | trimesh 平滑着色图引擎 |
| pillow | 10.4.0 | 图像读写（预留，当前代码未直接使用） |

## 部署步骤

### Windows

```bat
:: 1. 克隆仓库
git clone <your-repo-url>
cd <repo-name>

:: 2. 一键安装（首次，自动创建 venv 并安装依赖）
install.bat

:: 3. 一键启动（自动激活 venv 并运行主程序）
run.bat
```

### macOS

```bash
# 1. 克隆仓库
git clone <your-repo-url>
cd <repo-name>

# 2. 一键安装（首次，先赋予执行权限）
chmod +x install.sh run.sh
./install.sh

# 3. 一键启动（自动激活 venv 并运行主程序）
./run.sh
```

> **手动方式（可选）**：不想用一键脚本时，先激活环境再运行——Windows：`venv\Scripts\activate.bat` 然后 `python src\main.py`；macOS：`source venv/bin/activate` 然后 `python src/main.py`。

## 运行说明

- 推荐用 `run.bat`（Windows）/ `./run.sh`（macOS）一键启动：脚本会自动切到项目根目录、激活 venv 并运行 `src/main.py`。
- 入口统一在 `if __name__ == "__main__"` 中依次执行 AI 与 3D 两部分。
- **务必在项目根目录运行**（一键脚本已自动处理）：代码使用相对路径（`output/`、`assets/`），依赖当前工作目录。
- 运行全程无窗口弹出（离屏渲染），控制台打印完成信息后即结束。

## 输出说明

运行成功后 `output/` 生成两张图：

| 文件 | 内容 | 尺寸 | 说明 |
| --- | --- | --- | --- |
| `output/ai_edge.png` | Canny 边缘图 | 640×480 | numpy 测试图案经高斯模糊 + Canny 提取 |
| `output/lattice_3d.png` | 晶格长方体预览 | 640×480 | trimesh 离屏渲染的棋盘格晶格结构 |

## 常见兼容问题排查

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| `ModuleNotFoundError: No module named 'pyglet'` | 缺 trimesh 渲染后端 | `pip install "pyglet<2"`（已写入 requirements.txt） |
| `trimesh.viewer.windowed requires pyglet<2` | pyglet 装成了 2.x | `pip install "pyglet<2"` 降级 |
| `no graph engines available` / 3D 图空白 | 缺 scipy（平滑着色图引擎） | `pip install scipy`（已写入 requirements.txt） |
| `Library "EGL" not found` | 设置了 `PYGLET_HEADLESS`，Windows 无 EGL | 移除该环境变量，`visible=False` 已足够离屏 |
| `save_image() got multiple values for 'resolution'` | trimesh 4.4.9 的 save_image 不接收文件路径 | 用 `save_image(resolution=...)` 返回 bytes 再写文件 |
| `python` 命令打开 Microsoft Store | 装的是 Store 占位符，非真 Python | 到 python.org 安装 3.12，勾选 Add to PATH |
| `run.bat` / `run.sh` 提示未找到 venv | 还没安装依赖 | 先运行 `install.bat` / `./install.sh` |
| output 目录无图片 | 不在项目根目录运行 | 用一键脚本，或在项目根目录运行 |
| pip 安装依赖失败 | Python 版本过旧 | 升级到 Python 3.12 |

## 交付物清单

- **环境配置文档**：`requirements.txt`、`install.bat`、`install.sh`
- **一键启动脚本**：`run.bat`、`run.sh`
- **项目代码**：`src/main.py`（含 `src/__init__.py`）
- **运行说明**：`README.md`
- **复现自检清单**：`docs/reproduction-checklist.md`

## 版本控制约定

- `venv/`、`__pycache__/`、`output/`（运行结果）、模型文件等均被 `.gitignore` 忽略。
- `src/`、`docs/`、`assets/`、配置与脚本文件正常提交。
