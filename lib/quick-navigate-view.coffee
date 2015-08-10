{View, SelectListView} = require 'atom-space-pen-views'
fs = require 'fs'
path = require 'path'
tilde = require 'expand-tilde'

module.exports =
class QuickNavigateView extends SelectListView
    initialize: ->
        super
        @addClass('command-palette')
        atom.commands.add 'atom-workspace', 'quick-navigate:toggle', => @toggle()

    viewForItem: (item) ->
        "<li>#{item}</li>"

    confirmed: (item) ->
        @cancel()

    cancelled: ->
        @hide()

    show: ->

        @setItems(["1", "2"])
        @populateList()

        @panel ?= atom.workspace.addModalPanel(item: this)
        @panel.show()
        @storeFocusedElement()

        @focusFilterEditor()

    hide: ->
        @panel?.hide()

    toggle: ->
        if @panel?.isVisible()
            @cancel()
        else
            @show()
