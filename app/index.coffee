require('lib/setup')

Spine = require('spine')
Task = require('models/task')
Tasks = require('controllers/tasks')

class TaskApp extends Spine.Controller
  #trace: false
  logPrefix: "(TaskApp)"

  constructor: ->
    super
    Task.bind("create", @addOne)
    Task.bind("refresh", @addAll)
    Task.bind("refresh change", @renderCount)
    Task.fetch()

  events:
    "submit form": "create"
    "click .clear": "clear"

  elements:
    ".items": "items"
    ".countVal": "count"
    ".clear": "clearlink"
    "form input": "input"

  addOne: (task) =>
    @log "addOne: " + task
    tasks = new Tasks(item: task)
    @items.append(tasks.render().el)

  addAll: =>
    @log "addAll"
    Task.each(@addOne)

  create: (e) ->
    @log "create"
    e.preventDefault()
    Task.create(name: @input.val())
    @input.val("")

  clear: ->
    @log "clear"
    Task.destroyDone()

  renderCount: =>
    @log "renderCount"
    active = Task.active().length
    @count.text(active)

    inactive = Task.done().length
    if inactive
      @clearlink.show()
    else
      @clearlink.hide()

module.exports = TaskApp

