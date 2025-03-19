#import "../config.typ": *

#show: template.with([Composición])

#title-slide()

#let images = (
  277,
  282,
  283,
  285,
  286,
  291,
  294,
  297,
  298,
  299,
  300,
  301,
  302,
  303,
  306,
  307,
  308,
  310,
  312,
  315,
  316,
  317,
  319,
  320,
  321,
  322,
  324,
  325,
  326,
  330,
  333,
)

#let diagrams = (
  -60deg,
  120deg,
  -30deg,
  30deg,
  290deg,
  120deg,
  290deg,
  40deg,
  220deg,
  270deg,
  220deg,
  70deg,
  270deg,
  40deg,
  35deg,
  280deg,
  290deg,
  110deg,
  200deg,
  270deg,
  40deg,
  95deg,
  200deg,
  0deg,
  230deg,
  180deg,
  200deg,
  280deg,
  180deg,
  120deg,
  120deg,
)

#let meta = csv("metadata.csv", row-type: dictionary)

#let img_counter = 0

// set defaults
#let image_format = image_format.with(min_img_number: 277, meta: meta)
#set page(columns: 2)

#for img in images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  diagram_format(sun: diagrams.at(img_counter))
  img_counter += 1
}