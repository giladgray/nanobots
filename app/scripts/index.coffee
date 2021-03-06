Vector     = require 'pocket/src/utils/vector.coffee'
PairSystem = require 'pocket/src/utils/pair-system.coffee'

# configure the engine components
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
      32: 'SPAWN' # space
})

# basic components for game entities
pocket.component 'position', Vector.new()
pocket.component 'velocity', Vector.new()
pocket.component 'rotation', {angle: 0}
pocket.component 'health',   {health: 100}

bullets = require('./bullets.coffee') pocket

# create the nanobot! (returns its key)
nanobot = require('./nanobot.coffee') pocket

enemies = require('./enemies.coffee') pocket, nanobot

keyboard = pocket.getData 'keyboard'
pocket.system 'spawn-enemy', [], (pocket) ->
  if keyboard.isNewPress 'SPAWN'
    enemies.newEnemy()

# get things moving
pocket.systemForEach 'move-keys', ['position', 'velocity'], (pocket, key, pos, vel) ->
  Vector.add pos, vel

pocket.start()

window.pocket = pocket
