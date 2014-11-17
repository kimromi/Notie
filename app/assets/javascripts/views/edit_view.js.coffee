class Notie.Views.EditView extends Backbone.View
  el: '#view'
  template: JST["templates/notes/edit"]
  isChanged: false
  beforeTitle: ""
  beforeTag: ""
  beforeContent: ""

  events:
    "keyup #title" : "save_button"
    "keyup #input" : "marked"
    "change #tag"  : "tagChange"
    "click #update": "update"

  initialize: ->
    @render()
    markdown $("#input").val(), $("#preview")

  render: ->
    @$el.html @template(@model.toJSON())
    @setBefore()
    @$el.find('div.split-pane').splitPane()                             # split-pane
    tabIndent.render(document.getElementById('input'))                  # textarea tab indent
    @$el.find('#input').focus()                                         # focus
    @$el.find("#update").tooltip() if isTooltip()                       # update button tooltip
    @$el.find("#tag").tagit(placeholderText: 'TAG', singleField: true)  # tag input
    @

  save_button: (e)->
    @setChanged()
    title = $(e.target).val()
    @$el.find('#update').prop("disabled", !(title? and 0 < title.length))

  marked: ->
    @setChanged()
    markdown $("#input").val(), $("#preview")

  tagChange: ->
    @setChanged()

  update: (e)->
    $(e.target).prop("disabled", true).html($("<i>").addClass("fa fa-spin fa-spinner"))
    that = @
    @model.save {title: $("#title").val(), content: $("#input").val(), tag_list: $("#tag").val(), updated_at: Date.now()},
      success: (json) ->
        if "success" == json.attributes.result
          that.setBefore()
          that.setChanged()
          show_message "success", "success update note."
        else
          show_message "error", "falied update note."
      complete: ->
        $(e.target).prop("disabled", false).html("UPDATE")

  setBefore: ->
    @beforeTitle = $("#title").val()
    @beforeContent = $("#input").val()
    @beforeTag= $("#tag").val()

  setChanged: ->
    # isChange title or tag or content 
    @isChanged = (@beforeTitle != $("#title").val() || @beforeContent != $("#input").val() || @beforeTag != $("#tag").val())
    window.beforeunload(@isChanged)

  unload: ->
    if @isChanged
      confirm '入力中の内容が破棄されますがよろしいですか？'
    else
      true

  keydown = (e, event) =>
    if e.keyCode == 9   # tab
      if $(":focus").attr("id") == 'input'
        e.preventDefault()
    if (e.keyCode == 83 && e.ctrlKey) || (e.keyCode == 83 && e.metaKey)
      e.preventDefault()
      if !$('#update').prop("disabled")
        $('#update').click()

  window.keydown_event keydown
