class Notie.Routers.AppRouter extends Backbone.Router

  currentView: null
  currentHash: null

  routes:
    ""       : "list"
    "list"   : "list"
    "add"    : "add"
    ":uid/edit"   : "edit"

  initialize: (options)->
    @notes = new Notie.Collections.NotesCollection()
    @notes.reset options.notes
    @menu = new Notie.Views.MenuView({user: options.user})

  list: ->
    if @isPageChange()
      @clear()
      menu_active @menu.$el, "notes"
      @currentHash = Backbone.history.getFragment()
      @currentView = new Notie.Views.ListView({collection: @notes})
    else
      @navigate @currentHash,false

  add: ->
    if @isPageChange()
      @clear()
      menu_active @menu.$el, "add"
      @currentHash = Backbone.history.getFragment()
      @currentView = new Notie.Views.NewView({collection: @notes})
    else
      @navigate @currentHash,false

  edit: (uid) ->
    if @isPageChange()
      @clear()
      menu_active @menu.$el, "notes"
      @note = @notes.where({uid: uid})[0]
      @currentHash = Backbone.history.getFragment()
      @currentView = new Notie.Views.EditView({model: @note})
    else
      @navigate @currentHash,false

  navigate: (url, trigger) ->
    Backbone.history.navigate(url, {trigger: trigger})

  isPageChange: ->
    @currentHash == Backbone.history.getFragment() or _.isNull(@currentView) or (!_.isNull(@currentView) and @currentView.unload())

  clear: ->
    if !_.isNull(@currentView)
      window.keydown_event ()-> return    # keydown event initialize
      @currentView.undelegateEvents()     # event undelegate
      @currentView = null

