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

mouse    = pocket.getData 'mouse'
keyboard = pocket.getData 'keyboard'
canvas   = pocket.getData 'canvas'

pocket.component 'position', Vector.new()
pocket.component 'velocity', Vector.new()
pocket.component 'rotation', {angle: 0}
pocket.component 'nanobot',  {
  size: 30,
  speed: 5,
  color: 'cornflowerblue'
}

pocket.key
  'human-controlled-01': null
  nanobot: null
  position: Vector.new(canvas.width / 2, canvas.height / 2)
  velocity: null
  rotation: null

pocket.systemForEach 'move-nanobot', ['nanobot', 'velocity', 'human-controlled-01'],
  (pocket, key, nanobot, velocity) ->
    if keyboard.down.UP
      velocity.y = -nanobot.speed
    else if keyboard.down.DOWN
      velocity.y = nanobot.speed
    else
      velocity.y = 0
    if keyboard.down.LEFT
      velocity.x = -nanobot.speed
    else if keyboard.down.RIGHT
      velocity.x = nanobot.speed
    else
      velocity.x = 0

pocket.systemForEach 'rotate-nanobot', ['nanobot', 'position', 'rotation', 'human-controlled-01'],
  (pocket, key, nanobot, position, rotation) ->
    mouseVector = Vector.sub mouse.cursor, position, true
    rotation.angle = Vector.angle mouseVector

pocket.systemForEach 'move-keys', ['position', 'velocity'], (pocket, key, pos, vel) ->
  Vector.add pos, vel

# clear the canvas each frame
pocket.system 'clear-canvas', [], (pocket) ->
  {g2d, width, height} = canvas
  g2d.clearRect 0, 0, width, height

pocket.systemForEach 'draw-nanobot', ['nanobot', 'position', 'rotation'],
  (pocket, key, nanobot, position, rotation) ->
    size = nanobot.size
    {g2d} = canvas
    g2d.save()
    g2d.beginPath()
    g2d.translate position.x, position.y
    g2d.rotate rotation.angle
    g2d.fillStyle = nanobot.color
    g2d.fillRect -size / 2, -size / 2, size, size
    g2d.closePath()
    g2d.restore()

pocket.start()

window.pocket = pocket
