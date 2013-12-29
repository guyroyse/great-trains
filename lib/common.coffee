@HEIGHT = 24
@WIDTH = 48

@Hexes = new Meteor.Collection 'hexes'

@randomTerrain = ->
  _.sample ['Mountains', 'Hills', 'Forrest', 'Plains']

