#import "../config.typ": *

#show: template.with(title: [Retrato])

#title-slide()


#let images = range(709, 745).filter(it => it != 735)
#let diagrams = (180deg, 180deg, 170deg, 150deg, 80deg, 80deg, 90deg, 90deg, 90deg, 180deg, 180deg, 80deg, 30deg, 30deg, 120deg, 120deg, 120deg, 240deg, 300deg, 250deg, 250deg, 260deg, 260deg, 260deg, 220deg, 210deg, 210deg, 160deg, 160deg, 0deg, 280deg, 190deg, 280deg, 180deg, 180deg)

#let meta = csv("metadata.csv", row-type: dictionary)

#let image_format = image_format.with(min_img_number: 709, meta: meta)
#set page(columns: 2)

= Su Retrato
#let img_counter = 0

#for img in images {
  [ == Fotografía \# #(img_counter + 1)]
  image_format(img)
  diagram_format(sun: diagrams.at(img_counter))
  img_counter += 1
}


