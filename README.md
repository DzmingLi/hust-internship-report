# 华中科技大学生产（专业）实习报告 Typst 模板

本模板依据“网安2024版”报告本正文样式制作，不包含封面和封底。

## 仓库结构

```text
.
├── main.typ       # 报告入口；在注释提示处填写正文
├── template.typ   # 页面、字体、目录、标题和表格样式
├── .gitignore     # 忽略 PDF 等编译产物
└── README.md
```

## 使用方法

1. 安装 Typst 0.15 或更高版本。
2. 保持 `main.typ` 与 `template.typ` 在同一目录。
3. 在 `main.typ` 的注释提示处填写正文，并按需要增删章节；注释不会出现在 PDF 中。
4. 在当前目录执行：`typst compile main.typ`。

实时预览可执行：

```bash
typst watch main.typ preview.pdf
```

模板默认包含“使用注意事项/成绩评定页”和自动目录。如不需要，可在 `main.typ` 中把 `include-notice` 或 `include-outline` 改为 `false`。

## 主要版式

- 184.15 mm × 260.10 mm 纵向页面；四周边距与原报告本一致。
- 正文宋体小四、两端对齐、两字符首行缩进。
- 一级标题黑体三号、居中、另起一页；二级标题黑体四号、左对齐。
- 自动章节编号、目录、页码，以及表格、图片和提示框示例。
- 所需字体：SimSun、SimHei、Times New Roman；模板已按这些字体名称配置。
