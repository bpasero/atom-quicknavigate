QuickNavigateView = require './quick-navigate-view'
{CompositeDisposable} = require 'atom'

module.exports = QuickNavigate =

  activate: (state) ->
    @quickNavigateView = new QuickNavigateView()

  deactivate: ->
    @quickNavigateView.destroy()

  serialize: ->
    quickNavigateViewState: @quickNavigateView.serialize()
