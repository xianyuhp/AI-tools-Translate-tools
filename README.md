# 翻译 - 本地 AI 翻译工具

本地模型的桌面翻译工具，支持亚克力毛玻璃界面、在线大模型 API（DeepSeek / OpenAI / 火山方舟等）、模型自由切换、多语言界面。

## 功能特性

- **本地模型翻译（离线）**：通过 llama-cpp 在 CPU 上运行 GGUF 模型，无网络依赖、隐私安全
- **在线大模型 API**：OpenAI 兼容接口，支持 DeepSeek / OpenAI (GPT) / 火山方舟 (豆包) / 任意自定义服务商，流式输出
- **模型管理**：扫描 `models` 文件夹中的 `.gguf` 文件，一键刷新、自由切换；API Key 使用 Windows DPAPI 加密存储
- **界面**：仿百度翻译布局，亚克力毛玻璃效果，透明度 / 色调（跟随系统、浅色、深色、跟随强调色）可调，简体中文 / English 界面
- **使用引导**：首次启动自动展示本地模型与在线 API 的使用说明

## 运行源码

环境要求：Windows 10/11，Python 3.13

```bash
# 安装依赖
pip install PySide6 llama-cpp-python numpy requests

# 启动
python translator_app.py
```

`llama-cpp-python` 若无预编译 wheel，可从官方 CPU wheel 源安装：

```bash
pip install llama-cpp-python --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cpu --only-binary=:all:
```

## 使用方式

### 本地模型（离线）
1. 下载模型文件（.gguf），推荐 Qwen2.5-1.5B：
   https://modelscope.cn/models/Qwen/Qwen2.5-1.5B-Instruct-GGUF
2. 将 `.gguf` 文件放入程序同目录的 `models` 文件夹
3. 点击工具栏「⟳」刷新，在下拉框选择模型
4. 输入内容，点击「翻译」

### 在线大模型 API
1. 「设置」→ 引擎选择「在线大模型 API」
2. 「API 管理」→「添加」→ 选择服务商并填入 API Key / 模型名 / 接口地址
3. 直接输入内容翻译

## 打包为 EXE / 安装程序

使用 Nuitka 编译为原生可执行文件（可规避杀软对 PyInstaller 的启发误报）：

```bash
# 1. Nuitka 编译（需先安装 VS Build Tools / MSVC）
python -m nuitka --standalone --enable-plugin=pyside6 --windows-console-mode=disable \
  --include-package=llama_cpp --include-package-data=llama_cpp \
  --windows-icon-from-ico=app.ico --output-dir=nuitka_out \
  --output-filename=翻译.exe --assume-yes-for-downloads translator_app.py

# 2. Inno Setup 制作安装程序（自选安装路径）
ISCC.exe 翻译.iss
```

## 文件说明

| 文件 | 说明 |
| --- | --- |
| translator_app.py | 主程序源码 |
| 翻译.iss | Inno Setup 安装脚本 |
| version_info.txt | EXE 版本信息资源 |
| app.ico | 程序图标 |
| requirements.txt | Python 依赖清单 |

## 注意事项

- `config.json`（运行时自动生成）包含你的 API Key 配置，**请勿上传到公开仓库**
- `models` 文件夹存放本地模型，体积大，请勿上传
