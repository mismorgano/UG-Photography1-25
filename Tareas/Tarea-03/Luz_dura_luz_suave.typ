#import "../config.typ": *
#import "@preview/cetz:0.3.2"
#show: template.with([Luz dura y Luz suave])

#title-slide()

#let metadata = csv("metadata.csv", row-type: dictionary)

#let image_format(img_number) = {
  let index = img_number - 155
  let img_path = create_image_path(img_number)
  let img = metadata.at(index)
  let fnumber = img.at("EXIF FNumber")
  let exposuretime = img.at("EXIF ExposureTime")
  let ISO = img.at("EXIF ISOSpeedRatings")
  let date = img.at("Image DateTime")
  image(img_path)
  [

    / Apertura: #fnumber \
    / Velocidad: #exposuretime \
    / ISO: #ISO
    / Hora: #date
  ]
}

#let create_diagram(obj, sun) = {
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

#let diagram_format(obj, sun) = {
  block(breakable: false)[
    #align(center)[
      #create_diagram(obj, sun)
    ]
    / Yo: #emoji.camera
    / Objeto: #emoji.dino.rex
    / Sol: #emoji.sun
  ]
}

= Luz Dura

#let img_counter = 0
#let single_hard_images = (160, 192, 193, 216, 217, 218, 221, 222, 223, 224, 225, 227, 228)
#let group_hard_images = ((188, 189), (190, 191), (219, 220))
#let single_hard_diagrams = (190deg, 120deg, 270deg, 75deg, 0deg, 285deg, 240deg, 260deg, 280deg, 300deg, 280deg, 270deg, -30deg)
#let group_hard_diagrams = (290deg, 90deg, 180deg)
#let hard_diagrams = single_hard_diagrams + group_hard_diagrams

#hard_diagrams.len() fotos

#for single_hard_img in single_hard_images {
  [ == Fotografía \# #(img_counter + 1) ]
  set page(columns: 2)
  image_format(single_hard_img)
  diagram_format(90deg, hard_diagrams.at(img_counter))
  img_counter +=1
}

#for group_hard_img in group_hard_images {
  [ == Fotografía \# #(img_counter + 1) ]
  set page(columns: 2)
  for img_number in group_hard_img {
    image_format(img_number)
  }
  diagram_format(90deg, hard_diagrams.at(img_counter))
  img_counter += 1 
}



= Luz Suave

#let img_counter = 0
#let single_soft_images = (155, 156, 158, 159, 164, 167, 168, 169, 180, 181, 183, 186, 187, 197, 199, 200, 208, 209, 210, 211, 212, 214)
#let group_soft_images = ((170, 171, 174), (176, 177), (178, 179), (184, 185), (202, 203, 204))
#let single_soft_diagrams = (200deg, 190deg, 200deg, 290deg, 10deg, 0deg, -50deg, 120deg, 180deg, 0deg, 270deg, 280deg, -40deg, 60deg, -50deg, 60deg, 290deg, 290deg, 190deg, 20deg, 200deg, 210deg)
#let group_soft_diagrams = (210deg, 0deg, 120deg, 210deg, 30deg)
#let soft_diagrams = single_soft_diagrams + group_soft_diagrams


#soft_diagrams.len() fotos

#for single_image in single_soft_images {
  [ == Fotografía \# #(img_counter + 1) ]
  set page(columns: 2)
  image_format(single_image)
  diagram_format(90deg, soft_diagrams.at(img_counter))
  img_counter += 1
}

#for group_images in group_soft_images {
  [ == Fotografía \# #(img_counter + 1) ]
  set page(columns: 2)
  for img_number in group_images {
    image_format(img_number)
  }
  diagram_format(90deg, soft_diagrams.at(img_counter))
  img_counter += 1 
}