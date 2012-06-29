Spine = require('spine')
$ = Spine.$
Task = require('models/task')

class Tasks extends Spine.Controller
  #trace: false
  logPrefix: "(Tasks)"

  constructor: ->
    super
    @cid = @item.id
    @item.bind("update", @render)
    @item.bind("destroy", @release)

  events:
    "change input[type=checkbox]": "toggle"
    "click .destroy": "remove"
    "dblclick .view": "edit"
    "keypress input[type=text]": "blurOnEnter"
    "blur input[type=text]": "close"

  elements:
    "input[type=text]": "input"

  render: =>
    @log @cid + ".render: " + @item
    @replace($("#taskTemplate").tmpl(@item))
    @

  toggle: ->
    @log @cid + ".toggle"
    @item.done = !@item.done
    @item.save()

  remove: ->
    @log @cid + ".remove"
    @item.destroy()

  edit: ->
    @log @cid + ".edit"
    @el.addClass("editing")
    @input.focus()

  blurOnEnter: (e) ->
    if e.keyCode is 13 then e.target.blur()

  close: ->
    @log @cid + ".close"
    @el.removeClass("editing")
    @item.updateAttributes({name: @input.val()})

module.exports = Tasks
