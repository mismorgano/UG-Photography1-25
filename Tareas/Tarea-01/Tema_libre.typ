#import "@preview/touying:0.5.5": *
#import themes.university: *



#show: university-theme.with(aspect-ratio: "4-3", config-info(
  title: [Exposición correcta],
  author: [Antonio Barragán Romero],
  date: datetime.today().display("[day]-[month]-[year]"),
  institution: [Universidad de Guanajuato],
))

#let images = (
  2,
  3,
  7,
  9,
  10,
  11,
  12,
  14,
  16,
  20,
  22,
  24,
  27,
  28,
  30,
  31,
  32,
  33,
  34,
  35,
  39,
  40,
  43,
  44,
  45,
  50,
  51,
  52,
  53,
  65,
  66,
  67,
)

#title-slide()

#for img in images {
  let rep = 4 - str(img).len()
  let padded = "0" * rep
  let file_name = "IMG_" + padded + str(img) + ".jpg";
  let file_path = "/img/" + file_name
  image(file_path)
}
