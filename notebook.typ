#import "notebook-template.typ": internship-notebook, diary-entry

// 封面信息：将 none 改为 [要填写的内容]。
#show: internship-notebook.with(
  // 只在这里填写起止日期；封面和每日记录会自动使用。
  start-date: datetime(year: 2026, month: 5, day: 26),
  end-date: datetime(year: 2026, month: 7, day: 17),
  department: none,
  major-class: none,
  student-name: none,
  student-id: none,
  instructor: none,
  internship-organization: none,
)

// 在方括号内填写正文，复制 diary-entry 添加下一天的记录。
// 每个块顺延一个工作日（周一至周五），自动跳过双休日；装订补页不占用日期。
// 长内容自动续页；插入图片或表格时可传入 ruled: false 关闭横线。
#diary-entry[

]

/*
#diary-entry[
  在此填写下一天的实习笔记。
]
*/
