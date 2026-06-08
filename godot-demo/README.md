# The Line: Northbank - Godot Demo
## 《线：北岸》Godot Demo

## Current Build / 当前版本

当前版本是第一章《线外》的 Godot 4.x graybox playable build，已经导出 Windows playable build。它用于验证第一章主流程、场景节奏、交互系统、报告选择和临时 2.5D 视觉方向，不代表最终美术和最终剧本质量。

## How to Run / 运行方式

### Windows build

1. Open `godot-demo/releases/TheLineNorthbank_Demo_Windows.zip`.
2. Extract the zip file.
3. Run `TheLineNorthbank_Demo.exe`.

The current export embeds the Godot PCK into the executable. There is no separate `.pck` file in the zip.

GitHub download: [Windows ZIP](https://github.com/liiuuumemory/GameDoc/raw/main/godot-demo/releases/TheLineNorthbank_Demo_Windows.zip)

### Godot editor

1. Install Godot 4.x.
2. Open Godot.
3. Import `godot-demo/project.godot`.
4. Run the project.

If opening from the repository root, make sure to import `godot-demo/project.godot`, not the repository root.

## Playable Content / 当前可玩内容

- Main menu
- Survey Office
- Market Street
- Old Blocks
- Gate Two
- Report terminal
- Chapter 1 ending summary

The playable flow includes accepting the survey task, placing beacons, following the third beacon into Old Blocks, scanning local points, comparing layers, checking Gate Two facility data, submitting a report, and returning to the main menu.

## Controls / 操作

- Move: WASD / Arrow Keys
- Interact: E
- Close UI / Cancel: Esc
- Mouse: UI selection

## Placeholder Art / 临时美术

Current art resources are Art Pass 0 temporary 2.5D graybox assets:

`res://assets/placeholder_2_5d/`

Generation script:

`tools/generate_placeholder_art.py`

To regenerate placeholder SVG files:

```powershell
python tools/generate_placeholder_art.py
```

Final art can replace files with the same names, or scene `Texture2D` references can be updated in the relevant `.tscn` files.

## Known Issues / 已知问题

- Graybox art is still placeholder-only.
- UI and text pacing still need polish.
- Character dialogue and map rhythm are still being tuned.
- Chapter 2 is not implemented.
- This build is mainly for internal playtesting and flow validation.
- Report choices are not connected to later chapters yet.

## Not Included / 暂未包含

- 第二章《复核》
- 旧风道隐藏支线
- 下层结构或后期真相
- 主角身世
- 正式美术
- 完整音效
- 存档系统
