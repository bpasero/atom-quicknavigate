QuickNavigateView = require './quick-navigate-view'
{CompositeDisposable} = require 'atom'

module.exports = QuickNavigate =
  quickNavigateView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @quickNavigateView = new QuickNavigateView(state.quickNavigateViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @quickNavigateView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'quick-navigate:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @quickNavigateView.destroy()

  serialize: ->
    quickNavigateViewState: @quickNavigateView.serialize()

  toggle: ->
    console.log 'QuickNavigate was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
