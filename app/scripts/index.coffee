Vector     = require 'pocket/src/utils/vector.coffee'
PairSystem = require 'pocket/src/utils/pair-system.coffee'

pocket = require('./engine.coffee')({
  canvas:
    target : '#canvas'
    width  : 'auto'
    height : 'auto'
  mouse: {}
  keyboard:
    keymap:
      W: 'UP'
      A: 'LEFT'
      S: 'DOWN'
      D: 'RIGHT'
})

pocket.component 'position', Vector.new()
pocket.component 'velocity', Vector.new()
pocket.component 'rotation', {angle: 0}

require('./nanobot.coffee') pocket

pocket.systemForEach 'move-keys', ['position', 'velocity'], (pocket, key, pos, vel) ->
  Vector.add pos, vel

pocket.start()

window.pocket = pocket
