TILE_SIZE = 16
HEIGHT_IN_PIXELS = HEIGHT * TILE_SIZE + 4
WIDTH_IN_PIXELS = WIDTH * TILE_SIZE + TILE_SIZE / 2

Crafty.sprite TILE_SIZE, 20, 'terrain-tiles.png',
  Mountains : [0, 0]
  Hills     : [1, 0]
  Forrest   : [2, 0]
  Plains    : [3, 0]

hexes = {}

Crafty.c 'HexGrid',

  init : ->
    @attr
      w : TILE_SIZE
      h : TILE_SIZE

  withId : (id) ->
    @attr
      _id : id
    this

  at: (x, y) ->
    coords =
      x : if y % 2 is 0 then x * TILE_SIZE else x * TILE_SIZE + TILE_SIZE / 2
      y : y * TILE_SIZE
    @attr(coords)
    this

Crafty.c 'Hex',
  init : ->
    @requires '2D, Canvas, HexGrid'

addHex = (id, type, x, y) ->
  hex = Crafty.e('Hex, ' + type).at(x, y).withId(id)
  hexes[id] = hex

removeHex = (id) ->
  hexes[id].destroy
  delete hexes[id]

start = ->

  Crafty.init WIDTH_IN_PIXELS, HEIGHT_IN_PIXELS

  found = @Hexes.find()

  if found.count() is 0
    for x in [0...WIDTH]
      for y in [0...HEIGHT]
        @Hexes.insert
          type : @randomTerrain()
          x : x
          y : y

  found.observe
    added : (hex) ->
      addHex hex._id, hex.type, hex.x, hex.y
    removed: (hex) ->
      removeHex hex._id
      

  found.forEach (hex) ->
    addHex hex.type, hex.x, hex.y

@addEventListener 'load', ->
  start()

