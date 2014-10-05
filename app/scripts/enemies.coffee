Vector = require 'pocket/src/utils/vector.coffee'

module.exports = (pocket, nanobotKey) ->
  throw new Error('undefined nanobot key') unless nanobotKey
  canvas = pocket.getData 'canvas'

  pocket.component 'enemy', {
    size: 20
    color: 'red'
  }

  pocket.system 'enemies-target', ['enemy', 'position', 'velocity'],
    (pocket, keys, enemies, positions, velocities) ->
      nanobotPosition = pocket.dataFor nanobotKey, 'position'
      for key in keys
        enemy    = enemies[key]
        position = positions[key]

        targetAngle = Vector.angle Vector.sub(nanobotPosition, position, true)
        velocities[key] = Vector.fromPolar enemy.speed, targetAngle

  # draw the nanobot to the canvas
  {g2d} = canvas
  pocket.systemForEach 'draw-enemy', ['enemy', 'position', 'velocity'],
    (pocket, key, enemy, position, velocity) ->
      size = enemy.size
      g2d.save()
      g2d.beginPath()
      g2d.translate position.x, position.y
      g2d.rotate Vector.angle velocity
      g2d.fillStyle = enemy.color
      g2d.fillRect -size / 2, -size / 2, size, size
      g2d.closePath()
      g2d.restore()

  pocket.system 'enemy-health', ['enemy', 'health'], (pocket, keys, enemies, healths) ->
    killed = (key for key in keys when healths[key].health <= 0)
    pocket.destroyKeys killed
    console.log "killed #{killed.length} baddies" if killed.length

  return {
    newEnemy: ->
      pocket.key
        enemy:
          speed: 3
        health:
          health: 10
        position:
          x: _.random(50, canvas.width - 50)
          y: 50
        velocity: null
        rotation: null
  }
