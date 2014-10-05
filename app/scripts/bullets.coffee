PairSystem = require 'pocket/src/utils/pair-system.coffee'
Rectangle  = require 'pocket/src/utils/rectangle.coffee'

module.exports = (pocket) ->
  canvas = pocket.getData 'canvas'
  {g2d}  = canvas

  pocket.component 'bullet', {size: 10, damage: 1}
  pocket.component 'lifetime', (cmp, {time, born}) ->
    cmp.born = born or pocket.time
    cmp.time = time

  # destroy a key once its lifetime expires
  pocket.systemForEach 'lifetime', ['lifetime'], (pocket, key, lifetime) ->
    if lifetime.time? and pocket.time - lifetime.born >= lifetime.time
      pocket.destroyKey key

  # draw all the bullets in black
  pocket.system 'draw-bullets', ['bullet', 'position'],
    (pocket, keys, bullets, positions) ->
      g2d.beginPath()
      g2d.fillStyle = 'black'
      for key in keys
        {x, y} = positions[key]
        {size} = bullets[key]
        g2d.moveTo x, y
        g2d.arc x, y, size, 0, Math.PI * 2
      g2d.fill()
      g2d.closePath()

  pocket.system PairSystem.forEach 'bullet-enemy-collision',
    ['bullet', 'position', 'velocity'],
    ['enemy', 'position', 'health'],
    (pocket, [bKey, bullet, bPos, bVel], [eKey, enemy, ePos, eHP]) ->
      # current and previous bullet hitboxes, in case it just passed through enemy
      bRectNow = Rectangle.centered bPos.x, bPos.y, bullet.size * 2
      bRectPrev = Rectangle.centered bPos.x - bVel.x, bPos.y - bVel.y, bullet.size * 2
      # current enemy hitbox
      eRect = Rectangle.new(ePos.x, ePos.y, enemy.size)
      # if they collide, destroy both
      if Rectangle.overlap(bRectNow, eRect) or Rectangle.overlap(bRectPrev, eRect)
        pocket.destroyKey bKey
        eHP.health -= bullet.damage
