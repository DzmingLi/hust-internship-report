#let body-font = "SimSun"
#let heading-font = "SimHei"
#let latin-font = "Times New Roman"
#let cover-font = "STZhongsong"

#let cover-field(label, value: none) = grid(
  columns: (24mm, 66.5mm),
  align: (right + horizon, left + horizon),
  text(font: (latin-font, cover-font), size: 16pt)[#label],
  block(
    width: 66.5mm,
    height: 7mm,
    inset: (bottom: 1.2mm),
    stroke: (bottom: 0.55pt),
    align(center + bottom)[
      #if value != none { text(font: (latin-font, cover-font), size: 14pt)[#value] }
    ],
  ),
)

#let cover-page(
  department: none,
  major-class: none,
  student-name: none,
  student-id: none,
  instructor: none,
  internship-organization: none,
  start-date: none,
  end-date: none,
) = {
  assert((start-date == none) == (end-date == none), message: "请同时填写开始日期和结束日期，或同时设为 none")
  if start-date != none {
    assert(type(start-date) == datetime and type(end-date) == datetime, message: "起止日期须使用 datetime(year: ..., month: ..., day: ...)")
    assert(start-date <= end-date, message: "实习结束日期不能早于开始日期")
  }
  place(top + center, dy: 3mm)[
    #hide(text(font: (latin-font, body-font), size: 10.5pt)[（封面、封底用200克牛皮纸打印）])
  ]

  place(top + center, dy: 20mm)[
    #image("assets/hust-wordmark.jpg", width: 72.4mm)
  ]

  place(top + center, dy: 46mm)[
    #text(
      font: (latin-font, cover-font),
      size: 26pt,
      weight: "bold",
      tracking: 2pt,
      stroke: 0.18pt + black,
    )[生产（专业）实习报告本]
  ]

  place(top + center, dy: 82.3mm)[
    #grid(
      columns: (1fr,),
      row-gutter: 9.5mm,
      cover-field([院　　系], value: department),
      cover-field([专业班级], value: major-class),
      cover-field([姓　　名], value: student-name),
      cover-field([学　　号], value: student-id),
      cover-field([指导教师], value: instructor),
      cover-field([实习单位], value: internship-organization),
    )
  ]

  place(top + center, dy: 199mm)[
    #grid(
      columns: (39.6mm, 99mm),
      align: (left + horizon, left + horizon),
      text(font: (latin-font, cover-font), size: 16pt)[实习起止日期：],
      text(font: (latin-font, cover-font), size: 16pt)[
        #if start-date == none {
          grid(
            columns: (11.3mm, 14.1mm, 14.2mm, 14.1mm, 11.3mm, 14.1mm, 14.1mm, 5.8mm),
            align: left + horizon,
            [20], [年], [月], [日～], [20], [年], [月], [日],
          )
        } else {
          [#start-date.year() 年 #start-date.month() 月 #start-date.day() 日～#end-date.year() 年 #end-date.month() 月 #end-date.day() 日]
        }
      ],
    )
  ]
}

#let _heading-number(it) = {
  if it.numbering != none {
    counter(heading).display(it.numbering)
    h(0.75em)
  }
}

#let report-outline(depth: 2) = {
  place(top + center, dy: 4.95mm)[
    #text(font: "创艺简行楷", size: 14pt, tracking: 0.51pt)[华中科技大学生产（专业）实习报告]
  ]
  place(top + left, dy: 11.8mm)[#line(length: 100%, stroke: 0.7pt)]
  place(top + center, dy: 15.4mm)[
    #text(font: heading-font, size: 18pt, weight: "bold")[目录]
  ]
  place(top + left, dx: 2mm, dy: 25.7mm)[
    #block(width: 148.25mm)[
      #set text(font: (latin-font, body-font), size: 12pt)
      #set outline.entry(
        fill: text(font: latin-font, weight: "regular")[#repeat(gap: 0em)[.]],
      )
      #show outline.entry.where(level: 1): set text(weight: "bold")
      #show outline.entry: it => [#it#v(2.2mm)]
      #outline(
        title: none,
        depth: depth,
        indent: 0pt,
      )
    ]
  ]
  place(top + left, dy: 210mm)[#line(length: 100%, stroke: 0.45pt)]
}

#let score-table() = {
  set text(font: (latin-font, "DengXian"), size: 10pt)
  set par(justify: false, first-line-indent: 0em, leading: 0.9em)
  table(
    columns: (15.35mm, 10.23mm, 10.32mm, 14.54mm, 10.32mm, 10.24mm, 14.63mm, 10.32mm, 10.23mm, 16.14mm, 13.14mm, 13.14mm, 9.26mm),
    rows: (22mm, 5.73mm, 5.64mm, 5.64mm, 11.2mm),
    align: center + horizon,
    inset: (x: 1.2pt, y: 2.2pt),
    stroke: 0.45pt,
    table.cell()[毕业要\ 求 7.2\（H）],
    table.cell(colspan: 2)[毕业\ 要求\ 8.2（M）],
    table.cell()[毕业要\ 求 8.3\（L）],
    table.cell(colspan: 2)[毕业要求\ 10.1（H）],
    table.cell()[毕业要\ 求 11.1\（L）],
    table.cell(colspan: 2)[毕业要求\ 11.2（H）],
    table.cell()[毕业要\ 求 11.3\（M）],
    table.cell()[毕业\ 要求\ 12.1\（L）],
    table.cell()[毕业\ 要求\ 12.2\（H）],
    table.cell()[总\ 分],

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
  place(top + center, dy: 6.4mm)[
    #text(font: heading-font, size: 16pt, tracking: 0.4em)[使用注意事项]
  ]

  place(top + left, dx: 9.25mm, dy: 20.75mm)[
    #block(width: 136mm)[
      #set text(size: 10.5pt)
      #set par(leading: 0em, justify: false, first-line-indent: 0em)
      #grid(
        columns: (1fr,),
        rows: (5.5mm,),
        align: left + top,
        text(font: heading-font)[一、此本为生产（专业）实习报告专用。],
        text(font: heading-font, size: 10pt)[二、实习报告内容要求（应根据本专业生产（专业）实习大纲要求，按以下五项撰写）：],
        text(size: 10pt)[#grid(
          columns: (7.75mm, 45mm, 5mm, 1fr),
          [], [1.目录；], [], [4.在实习中收获最大与体会最深的内容；],
        )],
        text(size: 10pt)[#grid(columns: (7.75mm, 45mm, 5mm, 1fr), [], [2.实习内容分析；], [], [5.对实习工作的改进意见。])],
        text(size: 10pt)[#grid(columns: (7.75mm, 1fr), [], [3.专题内容分析；])],
        text(font: heading-font)[三、实习报告书写要求：],
        grid(columns: (7.75mm, 1fr), [], [1.报告内容（理、工科）一般不少于8000字；（文科）应不少于1万字；]),
        grid(columns: (7.75mm, 1fr), [], [2.一律用钢笔或圆珠笔书写，若书写页码不够用，可另附页；]),
        grid(columns: (7.75mm, 1fr), [], [3.字面整洁，字迹工整，图表清晰。]),
        text(font: heading-font)[四、实习成绩评定细则：],
      )
    ]
  ]

  place(top + left, dx: 9.25mm, dy: 75.7mm)[
    #block(width: 136mm)[
      #set text(size: 10.2pt)
      #set par(leading: 0.75em, justify: false, first-line-indent: 0em)
      #grid(
        columns: (1fr,),
        rows: (11mm, 11mm, 5.5mm, 5.5mm),
        [#h(2.1em)1.应根据学习实习任务完成情况、实习考试、实习日记、实习纪律等项目来综合评定成绩。],
        text(size: 10.5pt)[#h(2.04em)2.各项成绩在总成绩中所占比例，参照“实习总成绩评定表”规定的比例执行，具体评定时，各专业可根据本专业的实际情况，适当调整后再评定。],
        text(size: 10.5pt)[#h(2.04em)3.各项成绩可采用百分制记分。],
        text(size: 10.5pt)[#h(2.04em)4.实习总成绩评定表：],
      )
    ]
  ]

  place(top + left, dx: -2mm, dy: 107.6mm)[
    #block(width: 158mm)[#score-table()]
  ]

  place(top + left, dx: 9.25mm, dy: 165.2mm)[
    #block(width: 136mm)[
      #set text(size: 8.9pt)
      #set par(leading: 0em, justify: false, first-line-indent: 0em)
      #grid(
        columns: (1fr,),
        rows: (5.5mm,),
        grid(columns: (8mm, 3mm, 1fr), [], move(dy: -0.5mm)[#text(font: latin-font)[\*]], text(font: heading-font)[凡实习未能达到实习教学大纲基本要求，实习报告存在严重错误或弄虚作假情况，实习期]),
        text(font: heading-font)[间请假或缺勤达到实习总时间三分之一及以上、有严重违纪行为或导致较大责任事故的，实习成绩],
        text(font: heading-font)[以不及格记。实习期间有其他违反学习纪律或学术诚信行为的，按学校有关规定处理。],
      )
    ]
  ]

  place(top + left, dx: 79.75mm, dy: 192.5mm)[#text(font: heading-font)[指导教师签名：]#box(width: 30mm, inset: (bottom: 1.5pt), stroke: (bottom: 0.5pt))[]]
  place(top + left, dx: 108mm, dy: 203.5mm)[#text(font: (latin-font, body-font))[20#h(7.5mm)年#h(5.5mm)月#h(5.5mm)日]]
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

#let internship-report(
  body,
  department: none,
  major-class: none,
  student-name: none,
  student-id: none,
  instructor: none,
  internship-organization: none,
  start-date: none,
  end-date: none,
) = {
  set page(
    width: 184.15mm,
    height: 260.10mm,
    margin: (left: 15mm, right: 15mm, top: 20mm, bottom: 20mm),
    footer: none,
  )
  set text(font: (latin-font, body-font), size: 10.5pt, lang: "zh")
  set par(justify: true, leading: 0.75em, first-line-indent: 2em)

  cover-page(
    department: department,
    major-class: major-class,
    student-name: student-name,
    student-id: student-id,
    instructor: instructor,
    internship-organization: internship-organization,
    start-date: start-date,
    end-date: end-date,
  )
  pagebreak()
  counter(page).update(1)

  set page(
    width: 184.15mm,
    height: 260.10mm,
    margin: (left: 15mm, right: 15mm, top: 20mm, bottom: 20mm),
    footer-descent: 32.5%,
    footer: context align(center, text(size: 9pt)[#counter(page).display("1")]),
  )
  set text(font: (latin-font, body-font), size: 10.5pt, lang: "zh")
  set par(justify: true, leading: 0.75em, first-line-indent: 2em)
  set heading(numbering: "1.1")
  set outline.entry(fill: repeat[.])
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    // 页首的 `above` 会被折叠；用上内边距保留标题与页顶横线之间的距离。
    block(width: 100%, inset: (top: 23.4pt), below: 23.4pt, breakable: false)[
      #set text(font: (latin-font, heading-font), size: 16pt, weight: "bold")
      #align(center)[#_heading-number(it)#it.body]
    ]
  }
  show heading.where(level: 2): it => block(above: 15.6pt, below: 15.6pt, breakable: false)[
    #set par(first-line-indent: 0em)
    #set text(font: (latin-font, heading-font), size: 14pt, weight: "bold")
    #_heading-number(it)#it.body
  ]
  show figure.caption: set text(size: 10.5pt)
  show figure.caption: set align(center)

  notice-page()
  pagebreak()
  report-outline(depth: 2)
  pagebreak()
  set page(background: {
    place(top + left, dx: 15mm, dy: 20.1mm)[
      #line(length: 154.15mm, stroke: 0.7pt)
    ]
    place(top + left, dx: 15mm, dy: 232.8mm)[
      #line(length: 154.15mm, stroke: 0.45pt)
    ]
  })
  body
  pagebreak(weak: true)
  set page(background: none)
  // 封面占第 1 个物理页，封底落在偶数物理页，内页便能正反成对。
  pagebreak(weak: true, to: "even")
  page(header: none, footer: none, background: none, foreground: none)[]
}
