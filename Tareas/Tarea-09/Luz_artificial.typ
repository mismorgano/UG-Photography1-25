#import "../config.typ": *

#show: template.with(title: [Luz artificial])

#title-slide()

#let images = (758, 759, 762, 763, 764, 766, 767, 770, 771, 774, 776, 780, 785, 787, 789, 790, 791, 794, 798, 802, 804, 805, 834, 835, 836, 840, 842, 844, 846, 848, 850, 851, 859)
#let diagrams = ((85deg, ), (85deg, ), (0deg,), (270deg, ), (0deg,), (0deg, ), (0deg, ), (250deg, ), (270deg, ), (90deg, ), (90deg, ), (90deg, 290deg), (290deg, ), (-30deg, ), (-30deg, ), (90deg, ), (90deg, ), (150deg, ), (90deg, ), (270deg, ), (290deg, ), (290deg, ), (90deg, 290deg), (90deg, 290deg, ), (90deg, 290deg), (70deg, ), (70deg, ), (250deg, ), (90deg, 250deg), (90deg, 270deg), (90deg, 290deg),(90deg, -60deg), (270deg,))

#let meta = csv("metadata.csv", row-type: dictionary)

#let image_format = image_format.with(min_img_number: 745, meta: meta)
#set page(columns: 2)

= Luz artificial
#let img_counter = 0
#for img in images {
  [ == Fotografía \# #(img_counter + 1)]
  image_format(img)
  let diagram = diagrams.at(img_counter)
  if diagram.len() > 1 {
    diagram_format(sun: 270deg, lightbulb1: diagram.at(0), lightbulb2: diagram.at(1))  
  } else {
    diagram_format(sun: 270deg, lightbulb1: diagram)
  }
  
  img_counter += 1
}

  