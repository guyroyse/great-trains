rewriteBoard = ->
  @Hexes.remove {}
  for x in [0...WIDTH]
    for y in [0...HEIGHT]
      @Hexes.insert
        type : @randomTerrain()
        x : x
        y : y

Meteor.setInterval rewriteBoard, 10000

