# The Line: Northbank
## 《线：北岸》

电影化强叙事科幻 RPG 企划。玩家扮演一名测绘员，在北岸执行临时复核，逐渐发现轨道图层、地面图层、居民经验与设施记录之间无法对齐。

---

## Project Overview / 项目概述

《线：北岸》是一款电影化强叙事科幻 RPG。主角是一名测绘员，主要场景位于第七区段的北岸。当前体验围绕现场复核、报告选择，以及地图与现实之间的偏差展开。项目目前处于世界观、章节脚本、派系动机和隐藏支线整理阶段。

## Current Status / 当前状态

- 世界观基底：已建立
- 命名系统：已整理
- 第一章《线外》：Godot graybox playable build 已导出 Windows 包
- Godot playable demo：见 [godot-demo/README.md](../godot-demo/README.md) 和 [godot-demo/project.godot](../godot-demo/project.godot)
- Godot playable demo 下载：[Windows ZIP](https://github.com/liiuuumemory/GameDoc/raw/main/godot-demo/releases/TheLineNorthbank_Demo_Windows.zip)
- 第二章《复核》：文档设计中，尚未进入 demo
- 派系动机：居民、管理局、设施方、安息所、越线者已建立
- 隐藏支线《旧风道》：文档设定中，尚未进入 demo
- 北岸表层接缝设定：已加入世界观
- 真结局《仍有余温之地》：保留方向，不在 demo 中展开
- 主角身世：暂未写入当前版本

## Playable Build / 可玩版本

当前仓库包含一个 Windows playable build。

| Item | Path |
|---|---|
| Godot project | `godot-demo/project.godot` |
| Windows build | `godot-demo/releases/TheLineNorthbank_Demo_Windows.zip` |
| GitHub download | [Windows ZIP](https://github.com/liiuuumemory/GameDoc/raw/main/godot-demo/releases/TheLineNorthbank_Demo_Windows.zip) |
| Demo README | `godot-demo/README.md` |
| Build status | Playable graybox demo |

Windows zip 中包含 `TheLineNorthbank_Demo.exe`。当前导出使用 embedded PCK，没有单独 `.pck` 文件。

## Reading Order / 推荐阅读顺序

1. [项目概述](overview.md)
2. [文档版本管理](versioning.md)
3. [命名系统](naming-system.md)
4. [整体剧情结构](story-structure.md)
5. [北岸设定](world/northbank.md)
6. [派系动机](world/factions.md)
7. [越线者与传说](world/rumors-and-linebreakers.md)
8. [第一章：线外](story/chapter-01-outside.md)
9. [第二章：复核](story/chapter-02-review.md)
10. [隐藏支线：旧风道](story/hidden-old-duct.md)
11. [后期/真结局设定](world/lower-works.md) — Internal / 剧透内部资料

## Spoiler Level / 剧透等级

| Level | 含义 |
|---|---|
| Public | 可用于公开介绍，不涉及后期真相 |
| Design | 章节设计和系统设计，可给开发者阅读 |
| Spoiler | 后期剧情、隐藏支线、真结局相关 |
| Internal | 底层世界观真相，只供内部参考 |

## Versioning / 版本管理

- 每个主要文档只保留一个 `.md` 文件。
- 当前版本显示在文档上方。
- 历史版本保存在同一文件底部的折叠栏中。
- `index.md` 只链接当前主文档。
- 旧版本只作参考，不代表当前设定。
- 后续重大修改时，不要覆盖旧内容；先把旧内容移动到本文档底部的“历史版本归档”折叠栏，再更新当前版本。

## Document Index / 文档索引

| Category | Document | Version | Status | Spoiler Level | Notes |
|---|---|---|---|---|---|
| Overview | [项目概述](overview.md) | v0.3 | Draft | Public | 项目阶段与写作边界 |
| Versioning | [文档版本管理](versioning.md) | v0.2 | Draft | Public | 同文件历史版本规则 |
| Naming | [命名系统](naming-system.md) | v0.2 | Draft | Public | 英文正式名与中文正文用名 |
| Story | [整体剧情结构](story-structure.md) | v0.3 | Draft | Design | 四章结构与真结局路线 |
| World | [北岸设定](world/northbank.md) | v0.2 | Draft | Design | 北岸、表层接缝、温度反常 |
| World | [派系动机](world/factions.md) | v0.2 | Draft | Design | 居民、管理局、设施方、安息所、越线者 |
| World | [越线者与传说](world/rumors-and-linebreakers.md) | v0.2 | Draft | Design | 越线者材料与线外传言 |
| World | [后期/真结局设定](world/lower-works.md) | v0.2 | Draft | Internal | 底层世界观内部资料 |
| Story | [第一章：线外](story/chapter-01-outside.md) | v1.0 | Complete | Design | Demo 主体范围 |
| Story | [第二章：复核](story/chapter-02-review.md) | v0.2 | Draft | Design | 核查、名单、降载与分类 |
| Story | [隐藏支线：旧风道](story/hidden-old-duct.md) | v0.1 | Draft | Spoiler | 后期隐藏支线 |
| Story | [第三章：故障](story/chapter-03-failure.md) | v0.1 | Placeholder | Design | 七号泵房故障 |
| Story | [第四章：决定](story/chapter-04-decision.md) | v0.1 | Placeholder | Design | 最终复核报告 |
| Story | [真结局：仍有余温之地](story/true-ending-a-place-still-warm.md) | v0.1 | Placeholder | Spoiler | 真结局方向 |
| Design | [报告系统](design/report-system.md) | v0.1 | Draft | Design | 报告选项与后果 |
| Design | [测绘系统](design/survey-system.md) | v0.1 | Draft | Design | 信标、图层、模型偏差 |
| Design | [选择变量](design/choice-variables.md) | v0.1 | Draft | Design | 剧情变量方向 |
| Art | [视觉方向](art/visual-direction.md) | v0.1 | Draft | Public | 北岸视觉方向 |
| Production | [Demo 范围](production/demo-scope.md) | v0.2 | Playable | Public | 第一章 Windows playable build |
| Production | [Godot Demo Scope](../godot-demo/docs/demo-scope.md) | build-2026-06-09 | Playable | Public | Godot demo 范围 |
| Production | [Godot Implementation Plan](../godot-demo/docs/implementation-plan.md) | build-2026-06-09 | Playable | Public | Godot demo 实现状态 |
| Production | [Godot Demo README](../godot-demo/README.md) | build-2026-06-09 | Playable | Public | 运行方式与已知问题 |
| Production | [Windows ZIP](../godot-demo/releases/TheLineNorthbank_Demo_Windows.zip) | build-2026-06-09 | Playable | Public | 可下载试玩包 |

## Demo Scope / Demo 范围

当前 demo 聚焦第一章《线外》：

- 测绘办公室接任务
- 市场街布设信标
- 俊拿走第三个信标
- 旧街区扫描
- 图层对比
- 二号门设施数据
- 报告终端
- 第一章结尾摘要

暂不制作：

- 第二章
- 七号泵房完整故障
- 旧风道隐藏支线
- 真结局
- 主角身世
- 正式美术
- 完整音效
- 复杂存档

## Writing Guardrails / 写作边界

- 第一章和第二章不直接揭示下层结构真相。
- 不使用“古代文明入口”“地下神殿”“机器人”“黑太阳”“地底热脊”等直白词。
- 旧风道是被误用的非通行结构，不写成遗迹入口。
- 越线者不掌握真相，只持有误读的经验和传闻。
- 管理局、设施方、居民、安息所都不能写成单纯反派。
- 主角身世暂不写入当前版本。
- 正文不要反复写英文名词加中文括号。
- 减少排比、口号式总结和“不是 A 而是 B”句式。
- 保持设定隐晦，不要为了说明白而提前讲穿。

## Changelog / 最近更新

- 2026-06-09：导出 Windows playable build，并同步 Godot demo 下载与运行说明。
- 整理项目文档结构。
- 加入北岸表层接缝设定。
- 更新第二章《复核》新版冲突。
- 加入安息所与越线者。
- 加入隐藏支线《旧风道》。
- 确定真结局标题《仍有余温之地》。
- 增加写作边界、剧透等级和版本管理说明。
