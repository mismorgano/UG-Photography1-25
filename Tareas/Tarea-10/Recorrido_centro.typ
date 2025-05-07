#import "../config.typ": *

#show: template.with(title: [Recorrido Centro])

#title-slide()

#let images = (866, 880, 883, 887, 897, 903, 905, 910, 912, 918, 921, 929 , 949, 953, 958, 972, 989, 990, 997, 1011, 1012, 1031, 1039, 1045, 1046, 1049, 1053, 1059, 1069, 1076, 1081, 1086, 1091, 1106, 1110, 1114, 1121, 1124, 1133, 1141, 1157, 1160, 1173, 1184, )

#let diagrams = (180deg, 90deg, 160deg, 30deg, 60deg, 90deg, 30deg, 270deg, 300deg, 170deg, 270deg, 70deg, 60deg, 230deg, -10deg, -30deg, 180deg, 90deg, 60deg, 90deg, 90deg, 60deg, 330deg, 90deg, 90deg, 180deg, 170deg, 270deg, 60deg, 0deg, 180deg, 180deg, )

#let meta = csv("metadata.csv", row-type: dictionary)

#let image_format = image_format.with(min_img_number: 864, meta: meta)
#set page(columns: 2)

= Recorrido Centro
#let img_counter = 0
#for img in images {
  [ == Fotografía \# #(img_counter + 1)]
  image_format(img)
  if img_counter < diagrams.len() {
    let diagram = diagrams.at(img_counter)
    diagram_format(sun: diagram)
  }

  img_counter += 1
}