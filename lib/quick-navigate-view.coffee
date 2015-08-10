{View, SelectListView} = require 'atom-space-pen-views'

module.exports =
class QuickNavigateView extends SelectListView
    initialize: ->
        super

        @addClass('command-palette')
        atom.commands.add 'atom-workspace', 'quick-navigate:toggle', => @toggle()

    viewForItem: (item) ->
        "<li>#{item}</li>"

    confirmed: (item) ->
        atom.workspace.open(item)
        @cancel()

    cancelled: ->
        @hide()

    show: ->
        @setItems(atom.workspace.getPaneItems().map((m) => m.getURI()))
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
