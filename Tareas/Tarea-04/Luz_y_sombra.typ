#import "../config.typ": *

#show: template.with([Luz y sombra])

#title-slide()

#let single_images = (
  229,
  230,
  231,
  232,
  233,
  234,
  241,
  243,
  244,
  245,
  246,
  252,
  253,
  255,
  256,
  257,
  263,
  264,
  265,
  267,
  268,
  273,
  275,
)
#let group_images = ((235, 236), (237, 238, 239), (247, 248), (249, 250), (258, 259),)
#let single_diagrams = (
  30deg,
  190deg,
  270deg,
  0deg,
  40deg,
  275deg,
  20deg,
  185deg,
  30deg,
  100deg,
  130deg,
  270deg,
  190deg,
  190deg,
  0deg,
  100deg,
  10deg,
  120deg,
  190deg,
  270deg,
  -20deg,
  210deg,
  0deg,
)
#let group_diagrams = (190deg, 90deg, 130deg, 120deg, 10deg,)

// images and diagrams

#let diagrams = single_diagrams + group_diagrams

// metadata
#let meta = csv("../Tarea-04/metadata.csv", row-type: dictionary)

#let img_counter = 0

// set defaults
#let image_format = image_format.with(min_img_number: 229, images: single_diagrams, meta: meta)

#set page(columns: 2)

#for single_image in single_images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(single_image)
  diagram_format(sun: diagrams.at(img_counter))
  img_counter += 1
}

#for group_image in group_images {
  [ == Fotografía \# #(img_counter + 1) ]
  for img in group_image {
    image_format(img)
    diagram_format(sun: diagrams.at(img_counter))
  }
  img_counter += 1
}