class Notie.Views.NoteView extends Backbone.View
  tagName: "tr"
  className: "tr_note"
  template: JST["templates/notes/note"]

  events:
    "click .edit-note" : "edit"
    "click .show-note" : "shownote"
    "click .hide-note" : "hidenote"
    "click .download" : "download"
    "click .destroy" : "destroy"

  render: ->
    @$el.html @template(@model.toJSON())
    @

  edit: (e)->
    className = e.target.className
    if className.indexOf("destroy") >= 0 or className.indexOf("show-note") >= 0 or className.indexOf("hide-note") >= 0 or e.target.tagName == "I"
      return false
    location.href = "##{@model.attributes.uid}/edit"

  shownote: ->
    @$el.css("border", "none").next().show()
    @$el.find(".show-note i").addClass("fa-rotate-180")
    @$el.find(".show-note").removeClass("show-note").addClass("hide-note").find('span').text("HIDE")

  hidenote: ->
    @$el.css("border-bottom", "1px solid #EEE").next().hide()
    @$el.find(".hide-note i").removeClass("fa-rotate-180")
    @$el.find(".hide-note").removeClass("hide-note").addClass("show-note").find('span').text("SHOW")

  download: ->
    @$el.find(".download-form").submit()

  destroy: ->
    if confirm 'delete note?'
      if @$el.next().prop('style').display != "none"
        @$el.next().hide()
      @model.destroy()
      @remove()

    # @$el.next().hide()


  keydown = (e, event) =>
    index = $(".tr_note").index($(".selected"))
    switch e.keyCode
      when 37   # left key
        $(".tr_note:eq(" + index + ") .hide-note").click()
      when 38   # up key
        if index != 0
          $(".tr_note:eq(" + (index-1) + ")").addClass("selected").siblings().removeClass("selected")
      when 39   # right key
        $(".tr_note:eq(" + index + ") .show-note").click()
      when 40   # down key
        $(".tr_note:eq(" + (index+1) + ")").addClass("selected").siblings().removeClass("selected")
      when 13   # enter key
        if index >= 0
          $(".edit-note:eq(" + index + ")").click()
      when 46   # delete key
        if index >= 0
          $(".tr_note:eq(" + index + ") .destroy").click()
          index = $(".tr_note").length - 1 if index > $(".tr_note").length - 1
          $(".tr_note:eq(" + index + ")").addClass("selected").siblings().removeClass("selected")

  window.keydown_event keydown
