# 文档版本管理

> 当前版本：v0.2
> 最后更新：2026-06-09
> 状态：Draft
> 剧透等级：Public

<details>
<summary>历史版本</summary>

- 暂无归档版本。

</details>

---

## 当前版本

## 基本规则

每个主要文档只保留一个 `.md` 文件。当前版本放在文档上方，旧版本保存在同一文件底部的“历史版本归档”折叠栏中。

## 默认阅读版本

当前版本是默认阅读版本，也是在 `index.md` 中链接的版本。

## 历史版本

历史版本不创建单独文件，不放入 `history` 文件夹。

历史版本应放在同一文档底部：

```markdown
# Archived Versions / 历史版本归档

<details>
<summary>v0.1：版本说明</summary>

旧版本内容或摘要。

</details>
```

## 更新流程

1. 修改文档前，先把当前正文复制到本文档底部的历史版本归档区。
2. 给旧版本标注版本号、日期和简短说明。
3. 更新文档顶部当前版本号。
4. 更新当前正文。
5. 更新文档顶部的历史版本折叠栏。
6. 更新 `index.md` 中对应文档的版本号和状态。

## 注意

历史版本只作参考，不代表当前设定。

如果旧版本包含已废弃命名或设定，不需要删除，但应标注“已归档”。

## Release Sync

当 demo 导出 playable build 时，需要同步更新：

- 根目录 `README.md`
- 根目录 `index.md`
- `godot-demo/README.md`
- `docs/production/demo-scope.md`
- 相关 production 文档中的 build 状态和下载路径

当前 Windows playable build 路径：

`godot-demo/releases/TheLineNorthbank_Demo_Windows.zip`

---

# Archived Versions / 历史版本归档

<details>
<summary>暂无归档版本</summary>

暂无归档版本。

</details>
