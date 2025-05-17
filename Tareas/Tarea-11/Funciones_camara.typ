 #import "../config.typ": *

#show: template.with(title: [Funciones Cámara])


#title-slide()

#let images = (1205, 1206, 1207, 1209, 1211, 1217, 1218, 1220, 1222, 1226, 1227, 1228, 1231, 1232, 1235, 1237, 1239, 1242, 1244, 1246, 1247, 1261, 1263, 1268, 1270, 1276, 1277, 1279, 1281, 1283, 1284, 1293, 1300, 1309)

#let diagrams = (90deg, 50deg, 20deg, 270deg, 240deg, 180deg, 270deg, 70deg, 180deg, 200deg, 220deg, 180deg, 10deg, -30deg, 70deg, 160deg, 70deg, 70deg, 200deg, 200deg, 100deg, 110deg, 120deg, 270deg, 180deg, 90deg, 270deg, 290deg, 270deg, 30deg, 250deg, 290deg, 90deg, 90deg)

#let meta = csv("metadata.csv", row-type: dictionary)

#let image_format = image_format.with(min_img_number: 1204, meta: meta)
#set page(columns: 2)

= Funciones Cámara
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