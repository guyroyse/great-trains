TILE_SIZE = 16
HEIGHT = 24
WIDTH = 48
HEIGHT_IN_PIXELS = HEIGHT * TILE_SIZE
WIDTH_IN_PIXELS = WIDTH * TILE_SIZE + TILE_SIZE / 2

Crafty.sprite TILE_SIZE, 'terrain-tiles.png',
  Mountains : [0, 0]
  Hills     : [1, 0]
  Forrest   : [2, 0]
  Plains    : [3, 0]

Crafty.c 'HexGrid',

  init : ->
    dimensions =
      w : TILE_SIZE
      h : TILE_SIZE
    @attr(dimensions)

  at: (x, y) ->
    coords =
      x : if y % 2 is 0 then x * TILE_SIZE else x * TILE_SIZE + TILE_SIZE / 2
      y : y * TILE_SIZE
    @attr(coords)
    this

Crafty.c 'Hex',
  init : ->
    @requires '2D, Canvas, HexGrid'

addHex = (type, x, y) ->
  Crafty.e('Hex, ' + type).at(x, y)

start = ->

  Crafty.init WIDTH_IN_PIXELS, HEIGHT_IN_PIXELS
  Crafty.background 'rgb(0, 200, 255)'

  @Hexes.find().observe
    added : (hex) ->
      addHex hex.type, hex.x, hex.y

  @Hexes.find().forEach (hex) ->
    addHex hex.type, hex.x, hex.y

@addEventListener 'load', ->
  start()

