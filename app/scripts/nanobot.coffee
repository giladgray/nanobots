Vector = require 'pocket/src/utils/vector.coffee'

module.exports = (pocket) ->
  # cache input and rendering components
  mouse    = pocket.getData 'mouse'
  keyboard = pocket.getData 'keyboard'
  canvas   = pocket.getData 'canvas'

  # basic data about a nanobot
  pocket.component 'nanobot', {
    size: 30,
    speed: 5,
    color: 'cornflowerblue'
  }

  # make the nanobot itself!
  key = pocket.key
    'human-controlled-01': null
    nanobot: null
    position: Vector.new(canvas.width / 2, canvas.height / 2)
    velocity: null
    rotation: null

  # update velocity based on keyboard state
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

  # update rotation to point at the mouse cursor
  pocket.systemForEach 'rotate-nanobot', ['nanobot', 'position', 'rotation', 'human-controlled-01'],
    (pocket, key, nanobot, position, rotation) ->
      mouseVector = Vector.sub mouse.cursor, position, true
      rotation.angle = Vector.angle mouseVector

  # draw the nanobot to the canvas
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

  return key
