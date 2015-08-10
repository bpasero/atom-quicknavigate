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
        #atom.workspace.observeActivePaneItem (item) =>
        #    console.log item

    viewForItem: (item) ->
        console.log item
        "<li>#{item.getURI()}</li>"

    confirmed: (item) ->
        atom.workspace.open(item.getURI())
        @cancel()

    cancelled: ->
        @hide()

    show: ->
        @setItems(atom.workspace.getPaneItems())
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
