Spine = require('spine')

class Task extends Spine.Model
  @configure 'Task', "name", "done"

  @extend @Local

  @active: ->
    @select ( (item) -> !item.done )

  @done: ->
    @select ( (item) -> item.done )

  @destroyDone: ->
    item.destroy() for item in @done()

module.exports = Task
