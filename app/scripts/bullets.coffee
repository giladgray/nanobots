module.exports = (pocket) ->
  canvas = pocket.getData 'canvas'
  {g2d}  = canvas

  pocket.component 'bullet', {size: 10}
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
