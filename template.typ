// 华中科技大学生产（专业）实习报告 Typst 模板
// 依据“网安2024版”报告本正文制作；封面、封底已排除。

#let body-font = "SimSun"
#let heading-font = "SimHei"
#let latin-font = "Times New Roman"

#let _heading-number(it) = {
  if it.numbering != none {
    counter(heading).display(it.numbering)
    h(0.75em)
  }
}

#let report-label() = block(below: 11pt)[
  #align(center)[
    #text(font: heading-font, size: 16pt, weight: "bold")[华中科技大学生产（专业）实习报告]
  ]
  #v(5pt)
  #line(length: 100%, stroke: 0.7pt)
]

#let report-outline(depth: 2) = {
  report-label()
  v(12pt)
  align(center, text(font: heading-font, size: 16pt, weight: "bold")[目录])
  v(10pt)
  outline(
    title: none,
    depth: depth,
    indent: auto,
  )
}

#let score-table() = {
  set text(size: 10pt)
  table(
    columns: (9fr, 6fr, 6fr, 9fr, 6fr, 6fr, 9fr, 6fr, 6fr, 10fr, 8fr, 8fr, 5fr),
    rows: (22mm, 6mm, 6mm, 11mm, 11mm),
    align: center + horizon,
    inset: (x: 1.2pt, y: 2.2pt),
    stroke: 0.45pt,
    table.cell()[毕业要求\ 7.2（H）],
    table.cell(colspan: 2)[毕业要求\ 8.2（M）],
    table.cell()[毕业要求\ 8.3（L）],
    table.cell(colspan: 2)[毕业要求\ 10.1（H）],
    table.cell()[毕业要求\ 11.1（L）],
    table.cell(colspan: 2)[毕业要求\ 11.2（H）],
    table.cell()[毕业要求\ 11.3（M）],
    table.cell()[毕业要求\ 12.1（L）],
    table.cell()[毕业要求\ 12.2（H）],
    table.cell()[总分],

    [20分], table.cell(colspan: 2)[10分], [5分], table.cell(colspan: 2)[20分],
    [5分], table.cell(colspan: 2)[15分], [10分], [5分], [10分],
    table.cell(rowspan: 3)[100],

    [报], [答], [报], [答], [答], [答], [报], [答], [报], [报], [答], [答],
    [100%], [80%], [20%], [100%], [50%], [50%], [100%], [50%], [50%], [100%], [100%], [100%],
    [], [], [], [], [], [], [], [], [], [], [], [], [],
  )
}

#let notice-page() = {
  // 本页是固定行政表单。坐标由原 DOC 的正常字体渲染页实测得到，
  // 相对于 15 mm / 20 mm 的正文区域定位，避免流式内容改变表单版式。
  place(top + center, dy: 7.4mm)[
    #text(font: heading-font, size: 16pt, tracking: 0.4em)[使用注意事项]
  ]

  place(top + left, dx: 9mm, dy: 27mm)[
    #block(width: 136mm)[
      #set text(size: 10.5pt)
      #set par(leading: 0.35em, justify: true, first-line-indent: 0em)
      #grid(
        columns: (1fr,),
        row-gutter: 3.2mm,
        text(font: heading-font)[一、此本为生产（专业）实习报告专用。],
        text(font: heading-font)[二、实习报告内容要求（应根据本专业生产（专业）实习大纲要求，按以下五项撰写）：],
        grid(
          columns: (45mm, 1fr),
          column-gutter: 2mm,
          grid(columns: (1fr,), row-gutter: 3.2mm, [1.目录；], [2.实习内容分析；], [3.专题内容分析；]),
          grid(columns: (1fr,), row-gutter: 3.2mm, [4.在实习中收获最大与体会最深的内容；], [5.对实习工作的改进意见。]),
        ),
        text(font: heading-font)[三、实习报告书写要求：],
        [1.报告内容（理、工科）一般不少于8000字；（文科）应不少于1万字；],
        [2.一律用钢笔或圆珠笔书写，若书写页码不够用，可另附页；],
        [3.字面整洁，字迹工整，图表清晰。],
        text(font: heading-font)[四、实习成绩评定细则：],
        [#h(2em)1.应根据学习实习任务完成情况、实习考试、实习日记、实习纪律等项目来综合评定成绩。],
        [#h(2em)2.各项成绩在总成绩中所占比例，参照“实习总成绩评定表”规定的比例执行，具体评定时，各专业可根据本专业的实际情况，适当调整后再评定。],
        [#h(2em)3.各项成绩可采用百分制记分。],
        [#h(2em)4.实习总成绩评定表：],
      )
    ]
  ]

  place(top + left, dx: -2mm, dy: 113mm)[
    #block(width: 154mm)[#score-table()]
  ]

  place(top + left, dx: 9mm, dy: 176mm)[
    #block(width: 136mm)[
      #set text(size: 9pt)
      #set par(leading: 0.45em, justify: true, first-line-indent: 2em)
      \* 凡实习未能达到实习教学大纲基本要求，实习报告存在严重错误或弄虚作假情况，实习期间请假或缺勤达到实习总时间三分之一及以上、有严重违纪行为或导致较大责任事故的，实习成绩以不及格记。实习期间有其他违反学习纪律或学术诚信行为的，按学校有关规定处理。
    ]
  ]

  place(top + left, dx: 80mm, dy: 204mm)[指导教师签名：#h(30mm)]
  place(top + left, dx: 107mm, dy: 215mm)[20#h(8mm)年#h(6mm)月#h(6mm)日]
}

#let report-caption(kind: "表", body) = {
  align(center, block(above: 6pt, below: 5pt)[#kind #counter(kind).display("1")　#body])
  counter(kind).step()
}

#let report-table(columns: (), align: center + horizon, body) = table(
  columns: columns,
  align: align,
  inset: (x: 4pt, y: 3pt),
  stroke: 0.5pt,
  body,
)

#let report-figure(image-body, caption: none) = figure(
  image-body,
  caption: if caption == none { none } else { caption },
  supplement: [图],
  numbering: "1",
)

#let note(body) = block(
  width: 100%,
  inset: 7pt,
  stroke: (left: 1.2pt + black),
  fill: luma(245),
  body,
)

#let internship-report(body) = {
  set page(
    width: 184.15mm,
    height: 260.10mm,
    margin: (left: 15mm, right: 15mm, top: 20mm, bottom: 20mm),
    footer: context align(center, text(size: 9pt)[#counter(page).display("1")]),
  )
  set text(font: body-font, size: 10.5pt, lang: "zh")
  set par(justify: true, leading: 0.75em, first-line-indent: 2em)
  set heading(numbering: "1.1")
  set outline.entry(fill: repeat[.])
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(width: 100%, above: 23.4pt, below: 23.4pt, breakable: false)[
      #set text(font: heading-font, size: 16pt, weight: "bold")
      #align(center)[#_heading-number(it)#it.body]
    ]
  }
  show heading.where(level: 2): it => block(above: 15.6pt, below: 15.6pt, breakable: false)[
    #set par(first-line-indent: 0em)
    #set text(font: heading-font, size: 14pt, weight: "bold")
    #_heading-number(it)#it.body
  ]
  show figure.caption: set text(size: 10.5pt)
  show figure.caption: set align(center)

  notice-page()
  pagebreak()
  report-outline(depth: 2)
  pagebreak()
  body
}
