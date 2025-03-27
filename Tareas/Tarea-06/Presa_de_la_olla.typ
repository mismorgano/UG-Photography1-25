#import "../config.typ": *

#show: template.with(title: "Presa de la olla")


#title-slide()

// images
#let rhythm-images = (336, 340, 344, 352, 353, 359, 360, 370, 382, 390, 443, 448, 471, 477, 505, 545, 574)
#let texture-images = (337, 345, 358, 366, 367, 389, 395, 403, 406, 436, 440, 445, 474, 486, 492, 505, 516)
#let shape-images = (335, 341, 346, 369, 378, 383, 375, 392, 409, 417, 422, 427, 430, 490, 503, 524, 554)
#let free-images = (347, 349, 381, 384, 402, 458, 459, 463, 480, 496, 500, 529, 530, 532, 543, 568, 569, 595)

#let meta = csv("metadata.csv", row-type: dictionary)

// set defaults
#let image_format = image_format.with(min_img_number: 334, meta: meta)
#set page(columns: 2)

= Ritmo
#let img_counter = 0
#for img in rhythm-images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  img_counter += 1
}
= Textura 

#let img_counter = 0
#for img in texture-images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  img_counter += 1
}
= Forma 

#let img_counter = 0
#for img in shape-images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  img_counter += 1
}

= Temática libre 

#let img_counter = 0
#for img in free-images {
  [ == Fotografía \# #(img_counter + 1) ]
  image_format(img)
  img_counter += 1
}
