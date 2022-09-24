ThBasicv2View = require './th-basicv2-view'
{CompositeDisposable} = require 'atom'

module.exports = ThBasicv2 =
  thBasicv2View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @thBasicv2View = new ThBasicv2View(state.thBasicv2ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @thBasicv2View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'th-basicv2:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @thBasicv2View.destroy()

  serialize: ->
    thBasicv2ViewState: @thBasicv2View.serialize()

  toggle: ->
    console.log 'ThBasicv2 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
