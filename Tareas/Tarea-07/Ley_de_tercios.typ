#import "../config.typ": *

#show: template.with(title: [Ley de Tercios])

#title-slide()

#let images = (
  622,
  624,
  625,
  626,
  629,
  631,
  632,
  633,
  635,
  637,
  640,
  642,
  644,
  648,
  651,
  653,
  654,
  658,
  661,
  662,
  665,
  667,
  670,
  676,
  685,
  690,
  692,
  693,
  696,
  697,
  698,
  699,
  700,
  702,
  707,
  708,
)
#let diagrams = (
  140deg,
  270deg,
  110deg,
  120deg,
  30deg,
  280deg,
  250deg,
  -20deg,
  0deg,
  20deg,
  30deg,
  210deg,
  80deg,
  10deg,
  80deg,
  90deg,
  60deg,
  80deg,
  270deg,
  230deg,
  70deg,
  240deg,
  70deg,
  80deg,
  160deg,
  90deg,
  300deg,
  270deg,
  100deg,
  100deg,
  140deg,
  90deg,
  80deg,
  100deg,
  90deg,
  0deg,
)

#let meta = csv("metadata.csv", row-type: dictionary)

// set defaults
#let image_format = image_format.with(min_img_number: 622, meta: meta)
#let img_counter = 0

#set page(columns: 2)

#for img in images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  diagram_format(sun: diagrams.at(img_counter))
  img_counter += 1
}