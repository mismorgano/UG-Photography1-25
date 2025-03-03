#import "@preview/touying:0.5.5": *
#import themes.university: *


#let template(title, doc) = {  
  show: university-theme.with(aspect-ratio: "4-3", config-info(
    title: [#title],
    author: [Antonio Barragán Romero],
    date: datetime.today().display("[day]-[month]-[year]"),
    institution: [Universidad de Guanajuato],
  ))
  set terms(separator: [: ])
  doc
}

