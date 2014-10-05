Pocket = require 'pocket'

Canvas2D = require 'pocket/src/utils/canvas-2d.coffee'
MouseState    = require 'pocket/src/utils/mouse-state.coffee'
KeyboardState = require 'pocket/src/utils/keyboard-state.coffee'

module.exports = (options={}) ->
  pocket = new Pocket

  # register engine components
  pocket.component 'canvas', Canvas2D
  pocket.component 'mouse', MouseState
  pocket.component 'keyboard', KeyboardState
  # create engine keys with user options
  pocket.key {canvas   : options.canvas}
  pocket.key {mouse    : options.mouse}
  pocket.key {keyboard : options.keyboard}

  canvas = pocket.getData 'canvas'
  # clear the canvas each frame
  pocket.system 'clear-canvas', [], (pocket) ->
    canvas.g2d.clearRect 0, 0, canvas.width, canvas.height

  # render loop
  pocket.start = (time) ->
    pocket.tick(time)
    pocket.frameId = window.requestAnimationFrame pocket.start
  pocket.stop = ->
    window.cancelAnimationFrame pocket.frameId

  return pocket
