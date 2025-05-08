#import "@preview/touying:0.6.1": *
#import "@preview/cetz:0.3.3"
#import themes.university: *


#let template(title: [], doc) = {
  show: university-theme.with(aspect-ratio: "4-3", config-info(
    title: [#title],
    subtitle: [_Fotografía 1 - Diseño Gráfico_],
    author: [Antonio Barragán Romero],
    date: datetime.today().display("[day]-[month]-[year]"),
    institution: [Universidad de Guanajuato],
    logo: emoji.camera,
  ))
  set terms(separator: [: ])
  doc
}

#let create_image_path(dir, n) = {
  let rep = 4 - str(n).len()
  let padded = "0" * rep
  let file_name = "IMG_" + padded + str(n) + ".jpg";
  let file_path = dir + file_name
  file_path
}


#let image_metadata(img) = {
  let f_number = img.at("EXIF FNumber")
  let exposure_time = img.at("EXIF ExposureTime")
  let ISO = img.at("EXIF ISOSpeedRatings")
  let date = img.at("Image DateTime")
  let mode = img.at("MakerNotes:EasyMode")
  block(breakable: false)[
    / Apertura: #f_number
    / Velocidad: #exposure_time
    / ISO: #ISO
    / Hora: #date
    / Modo: #mode
  ]
}

#let create_diagram(obj: 90deg, sun: 0deg, lightbulb1: none, lightbulb2: none) = {
  cetz.canvas({
    import cetz.draw: *

    let (a, b) = ((-6, -4), (6, 4))
    rect(a, b, name: "plane_sun")
    rect((a.at(0) + 2, a.at(1) + 2), (b.at(0) - 2, b.at(1) - 2), name: "plane_obj", stroke: none)
    rect((a.at(0) + 1, a.at(1) + 1), (b.at(0) - 1, b.at(1) - 1), name: "plane_lightbulb", stroke: none)


    content("plane_obj.center", emoji.camera)
    content((name: "plane_obj", anchor: obj), emoji.dino.rex)
    if sun != none {
      content((name: "plane_sun", anchor: sun), emoji.sun)
    }
    if lightbulb1 != none {
      content((name: "plane_lightbulb", anchor: lightbulb1), emoji.lightbulb)
    }
    if lightbulb2 != none {
      content((name: "plane_lightbulb", anchor: lightbulb2), emoji.lightbulb)
    }
  })
}

#let diagram_format(obj: 90deg, sun: 0deg, lightbulb1: none, lightbulb2: none) = {
  block(breakable: false)[
    #align(center)[
      #create_diagram(obj: obj, sun: sun, lightbulb1: lightbulb1, lightbulb2: lightbulb2)
    ]
    / Yo: #emoji.camera
    / Objeto: #emoji.dino.rex
    / Sol: #emoji.sun
    #if lightbulb1 != none {
      [ / Foco: #emoji.lightbulb ]
    }
  ]
}


#let image_format(dir: "/img/", img_number, min_img_number: 0, meta: ()) = {
  let index = img_number - min_img_number
  let img_path = create_image_path(dir, img_number)
  let img = meta.at(index)
  image(img_path)
  image_metadata(img)
}
