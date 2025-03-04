#import "../config.typ": template, title-slide, slide, components
#import "@preview/cetz:0.3.2"

#show: template.with([Sobre, normal y sub exposición ])

#set terms(separator: [: ])

#title-slide()



#let metadata = csv("metadata.csv", row-type: dictionary)

// #slide()[
//   #set page(paper: "a4")
//   = Foto 1
//   #grid(rows: 3)[
//     #image("/img/IMG_0076.jpg")
//     #image("/img/IMG_0076.jpg")
//     #image("/img/IMG_0076.jpg")
//   ]
// ]

#let pattern = ("Sobre expuesta", "Normal", "Sub expuesta", "Sub expuesta", "Normal", "Sobre expuesta")
#let diagrams = (
  (obj: 90deg, sun: 90deg),
  (obj: 90deg, sun: 280deg),
  (obj: 90deg, sun: -30deg),
  (obj: 90deg, sun: 45deg),
  (obj: 120deg, sun: 210deg),
  (obj: 90deg, sun: 0deg),
  (obj: 90deg, sun: 90deg),
  (obj: 90deg, sun: 180deg),
  (obj: 90deg, sun: 45deg),
  (obj: 90deg, sun: 30deg),
  (obj: 90deg, sun: 210deg),
  (obj: 90deg, sun: 45deg),
  (obj: 90deg, sun: 270deg),
  (obj: 90deg, sun: 0deg),
  (obj: 90deg, sun: 20deg),
  (obj: 90deg, sun: 200deg),
  (obj: 90deg, sun: 250deg),
  (obj: 90deg, sun: 20deg),
  (obj: 95deg, sun: 95deg),
  (obj: 90deg, sun: 260deg),
  (obj: 90deg, sun: 290deg),
  (obj: 90deg, sun: 270deg),
  (obj: 90deg, sun: 270deg),
  (obj: 90deg, sun: 135deg),
  (obj: 90deg, sun: 90deg),
)


#let imgcounter = 0
#let excludes = (74, 89, 96, 101,)
#let image_group = ()

#let create_image_path(n) = {
  let rep = 4 - str(n).len()
  let padded = "0" * rep
  let file_name = "IMG_" + padded + str(n) + ".jpg";
  let file_path = "/img/" + file_name
  file_path
}

#let image_matadata(img, pattern_index) = {
  let fnumber = img.at("EXIF FNumber")
  let exposuretime = img.at("EXIF ExposureTime")
  let ISO = img.at("EXIF ISOSpeedRatings")
  [
    #align(center)[*#pattern.at(calc.rem(pattern_index, pattern.len()))*]
    - *Apertura:* #fnumber \
    - *Velocidad:* #exposuretime \
    - *ISO:* #ISO

  ]
}

#let image_format(img, pattern_index) = {
  let img_number = img.at("Image Number")
  let img_path = create_image_path(img_number)
  block()[
    #image(img_path)
    #image_matadata(img, pattern_index)
  ]
}
// #let img_counter = 0 
// #while img_counter < metadata.len() {
//   let img = metadata.at(img_counter)
//   let image_number = int(img.at("Image Number"))

//   if image_number in excludes or img.at("EXIF FNumber") == "" {
//     continue
//   }
//   img_counter += 1
// }

#for img in metadata {
  // set rect(fill: rgb(23, 45, 56, 90), width: 100%)
  // let pos = context imgcounter.get()
  // imgcounter.step()
  // metadata.at(imgcounter)
  let img_number = int(img.at("Image Number"))
  if img_number in excludes or img.at("EXIF FNumber") == "" {
    continue
  }
  // if imgcounter > 25*3 {
  //   break
  // }
  if image_group.len() == 3 {
    let photo_number = int(calc.round(imgcounter / 3))
    [ == Fotografía \# #photo_number ]
    set page(columns: 2)
    let i = 3
    for img_index in image_group {
      let pattern_index = imgcounter - i
      image_format(img_index, pattern_index)
      i -= 1
    }
    // colbreak()
    block(breakable: false)[
      #align(center)[
        *Diagrama*
        #cetz.canvas({
          import cetz.draw: *
          let diagram = diagrams.at(photo_number - 1)
          let (a, b) = ((-5, -3), (5, 3))
          rect(a, b, name: "plane_sun")
          rect((a.at(0) + 1.5, a.at(1) + 1.5), (b.at(0) - 1.5, b.at(1) - 1.5), name: "plane_obj", stroke: none)

          content("plane_obj.center", emoji.camera)

          content((name: "plane_obj", anchor: diagram.obj), emoji.dino.rex)
          content((name: "plane_sun", anchor: diagram.sun), emoji.sun)
          // circle((0, 2), radius: .2, name: "sun", fill: yellow)
          // content("plane.0deg", emoji.sun)
          // content("plane.25%", emoji.sun)
          // content("plane_sun.north", emoji.sun)
          // content("plane.south-west", emoji.sun)
          // content("plane.315deg", emoji.sun)
          // content("plane.50%", emoji.sun)
        })
      ]
      / Yo: #emoji.camera
      / Objeto: #emoji.dino.rex
      / Sol: #emoji.sun
    ]
    image_group = ()
  }

  // if image_group.len() == 3 {
  //   for img_index in image_group {
  //     let img_m = metadata.at(img_index)

  //   }
  //   [ == Fotografía \# #calc.round(imgcounter / 3) ]
  //   slide()[
  //     // = title
  //     // == Fotografía \# #(calc.round(imgcounter /3))

  //     #figure(image(create_image_path(int(image_group.at(0).at("Image Number")))), caption: {
  //       // image_group.at(0).at("EXIF FNumber");
  //       // v(1pt)
  //       // image_group.at(0).at("EXIF ExposureTime")
  //       // image_group.at(0).at("Image DateTime")
  //       image_matadata(img_number)
  //     })
  //     #image(create_image_path(int(image_group.at(1).at("Image Number")))),

  //     //   #grid(
  //     //     columns: (1fr, 1fr),
  //     //     rows: (1fr, 1fr),
  //     //     // fill: rgb(23, 34, 23, 90),
  //     //     figure(image(create_image_path(int(image_group.at(0).at("Image Number")))), caption: {
  //     //       image_group.at(0).at("EXIF FNumber");
  //     //       v(1pt)
  //     //       image_group.at(0).at("EXIF FNumber")
  //     //       image_group.at(0).at("Image DateTime")
  //     //     }),
  //     //     image(create_image_path(int(image_group.at(1).at("Image Number")))),
  //     //     image(create_image_path(int(image_group.at(2).at("Image Number")))),
  //     //     cetz.canvas({
  //     //       import cetz.draw: *

  //     //       rect((-2, -2), (2, 2))

  //     //       circle((0, 0), radius: .2, name: "center")
  //     //       content("center", "Yo")

  //     //       circle((0, 2), radius: .2, name: "sun", fill: yellow)
  //     //       content("sun", "Sol")
  //     //     }),
  //     //     // for image_ in images {
  //     //     //   grid.cell(image(create_image_path(int(image_.at("Image Number")))))
  //     //     //   // image_.at("Image Number")
  //     //     // }
  //     //     // image(create_image_path(int(images.at(0).at("Image Number")))),
  //     //     // images.at(1).at("EXIF ISOSpeedRatings"),
  //     //     // images.at(2).at("EXIF ExposureTime"),
  //     //   )
  //   ][
  //     #image(create_image_path(int(image_group.at(2).at("Image Number")))),
  //     #cetz.canvas({
  //       import cetz.draw: *

  //       rect((-2, -2), (2, 2))

  //       circle((0, 0), radius: .2, name: "center")
  //       content("center", emoji.camera)

  //       circle((0, 2), radius: .2, name: "sun", fill: yellow)
  //       content("sun", emoji.sun)
  //     })
  //   ]
  //   // image_group = ()
  // }
  let format_metadata = for (key, value) in img {
    if value != "" {
      set text(size: 12pt)

      [#key : *#value * \
        #pattern.at(calc.rem(imgcounter, pattern.len()))
        #create_image_path(img_number)
      ]
    }
  }
  image_group.push(img)
  imgcounter += 1
  // images = ()
}


