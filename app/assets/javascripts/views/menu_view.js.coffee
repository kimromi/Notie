class Notie.Views.MenuView extends Backbone.View
  el: '#menu'
  template: JST["templates/notes/menu"]

  events:
    "change #config-keyshortcut": "keyshortcut"

  initialize: (options)->
    @render(options.user)

  render: (user)->
    @$el.html @template(user)
    @$el.find("#menu_user_name").html($("#user-name").val())               # user mame
    @$el.find("#menu-notes").tooltip(placement : 'bottom') if isTooltip()  # tooltip
    @$el.find("#menu-add").tooltip(placement : 'bottom') if isTooltip()    # tooltip

  keyshortcut: (e)->
    if "true" == $(e.target).val()
      $("#menu-notes").tooltip(placement : 'bottom')
      $("#menu-add").tooltip(placement : 'bottom')
    else
      $("#menu-notes").tooltip("destroy")
      $("#menu-add").tooltip("destroy")

  keydown = (e, event) =>
    if (e.keyCode == 27)              # esc
      e.preventDefault()
      window.router.navigate "#list",true
    if (e.keyCode == 78 && e.altKey)  # alt+n
      e.preventDefault()
      window.router.navigate "#add",true

  window.keydown_event keydown


