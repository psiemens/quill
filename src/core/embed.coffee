_          = require('lodash')
Delta      = require('rich-text/lib/delta')
dom        = require('../lib/dom')
Format     = require('./format')
Leaf       = require('./leaf')
Line       = require('./embed')
LinkedList = require('../lib/linked-list')
Normalizer = require('../lib/normalizer')


class Embed extends LinkedList.Node
  @CLASS_NAME : 'ql-embed'
  @ID_PREFIX  : 'ql-embed-'

  constructor: (@doc, @node) ->
    @id = _.uniqueId(Embed.ID_PREFIX)
    @formats = {}
    dom(@node).addClass(Embed.CLASS_NAME)
    @node.setAttribute('contenteditable', false)
    this.rebuild()
    this._clickListener()
    super(@node)

  _clickListener: =>
    dom(@node).on('click', =>
      @doc.editor.selection.selectEmbed(this)
    )

  getJSON: ->
    return false unless typeof @controller != 'undefined'
    return @controller.getJSON()
module.exports = Embed
