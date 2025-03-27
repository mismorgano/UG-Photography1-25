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

#let create_image_path(n) = {
  let rep = 4 - str(n).len()
  let padded = "0" * rep
  let file_name = "IMG_" + padded + str(n) + ".jpg";
  let file_path = "/img/" + file_name
  file_path
}


#let image_metadata(img) = {
  let f_number = img.at("EXIF FNumber")
  let exposure_time = img.at("EXIF ExposureTime")
  let ISO = img.at("EXIF ISOSpeedRatings")
  let date = img.at("Image DateTime")
  [

    - / Apertura: #f_number
    - / Velocidad: #exposure_time
    - / ISO: #ISO
    - / Hora: #date
  ]
}

#let create_diagram(obj: 90deg, sun: 0deg) = {
  cetz.canvas({
    import cetz.draw: *

    let (a, b) = ((-5, -3), (5, 3))
    rect(a, b, name: "plane_sun")
    rect((a.at(0) + 1.5, a.at(1) + 1.5), (b.at(0) - 1.5, b.at(1) - 1.5), name: "plane_obj", stroke: none)

    content("plane_obj.center", emoji.camera)

    content((name: "plane_obj", anchor: obj), emoji.dino.rex)
    content((name: "plane_sun", anchor: sun), emoji.sun)
  })
}

#let diagram_format(obj: 90deg, sun: 0deg) = {
  block(breakable: false)[
    #align(center)[
      #create_diagram(obj: obj, sun: sun)
    ]
    / Yo: #emoji.camera
    / Objeto: #emoji.dino.rex
    / Sol: #emoji.sun
  ]
}


#let image_format(img_number, min_img_number: 0, meta: ()) = {
  let index = img_number - min_img_number
  let img_path = create_image_path(img_number)
  let img = meta.at(index)
  image(img_path)
  image_metadata(img)
}
