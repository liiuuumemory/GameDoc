# The Line: Northbank - Godot Demo

## 当前版本

这是第一章《线外》的 Godot 4.x 灰盒 playable demo。当前版本用于验证第一章主流程、场景节奏、交互系统、报告选择和临时 2.5D 视觉方向。

## 运行方式

1. 安装 Godot 4.x。
2. 打开 Godot。
3. 选择 **Import** / **Open**。
4. 选择 `godot-demo/project.godot`。
5. 点击 **Run**。

如果从仓库根目录打开，请确认导入的是 `godot-demo/project.godot`，不是仓库根目录。

## 当前可玩内容

- 测绘办公室接收临时复核任务
- 领取测绘仪和三枚信标
- 市场街布设信标
- 第三枚信标偏移到旧街区
- 与俊、陈玛拉、沃德女士等角色进行短对话
- 旧街区现场扫描
- 轨道图层与地面图层对比
- 二号门读取设施侧数据
- 返回测绘办公室提交第一章报告
- 查看第一章结尾摘要并返回主菜单

## 操作

- 移动：WASD 或方向键
- 交互：E
- 关闭当前弹出 UI：Esc 或 UI 内的关闭按钮

## 临时美术

当前美术资源是 Art Pass 0 的临时 2.5D 灰盒资源，路径：

`res://assets/placeholder_2_5d/`

资源生成脚本：

`tools/generate_placeholder_art.py`

如需重新生成占位 SVG：

```powershell
python tools/generate_placeholder_art.py
```

正式美术可通过保持同名文件替换，或在 `.tscn` 场景中更新 `Texture2D` 引用。

## 暂未实现

- 第二章
- 旧风道隐藏支线
- 真结局
- 正式美术
- 完整音效
- 复杂存档
- 报告选择对后续章节的完整影响

## 已知问题

- 灰盒美术仍为占位资源。
- 对话和地图节奏仍需继续打磨。
- UI 视觉不是最终版。
- 信标与扫描反馈目前使用文字提示，完整音效尚未制作。
- 报告后续影响暂未接入后续章节。
