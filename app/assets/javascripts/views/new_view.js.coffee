class Notie.Views.NewView extends Backbone.View
  el: '#view'
  template: JST["templates/notes/new"]
  isChanged: false
  beforeTitle: ""
  beforeTag: ""
  beforeContent: ""

  events:
    "keyup #title": "save_button"
    "keyup #input": "marked"
    "change #tag" : "tagChange"
    "click #save" : "save"

  initialize: ->
    @render()

  render: ->
    @$el.html @template
    @$el.find('div.split-pane').splitPane()                             # split-pane
    tabIndent.render(document.getElementById('input'))                  # textarea tab indent
    @$el.find('#title').val(today).focus()                              # title set today and focus
    @setBefore()
    @$el.find("#save").tooltip() if isTooltip()                         # save button tooltip
    @$el.find("#tag").tagit(
      placeholderText: 'TAG',
      singleField: true,
      availableTags: $("#config-taglist").val().split(","),
      autocomplete: {delay: 0, minLength: 0})                           # tag input
    @

  save_button: (e)->
    @setChanged()
    title = $(e.target).val()
    @$el.find('#save').prop("disabled", !(title? and 0 < title.length))

  marked: ->
    @setChanged()
    markdown $("#input").val(), $("#preview")

  tagChange: ->
    @setChanged()

  save: (e)->
    $(e.target).prop("disabled", true).html($("<i>").addClass("fa fa-spin fa-spinner"))   # saving..
    model = new Notie.Models.NoteModel({title: $("#title").val(), content: $("#input").val(), tag_list: $("#tag").val(), create_at: Date.now(), updated_at: Date.now()})
    that = @
    @collection.create model,
      success : (json)->
        if "success" == json.attributes.result
          show_message "success", "success save note."
          that.setBefore()
          that.setChanged()
          window.router.navigate "##{json.attributes.uid}/edit",true
        else
          show_message "error", "falied save note."
      complete: ->
        $(e.target).prop("disabled", false).html("SAVE")

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
    if (e.keyCode == 83 && e.ctrlKey) || (e.keyCode == 83 && e.metaKey)   # ctrl+s
      e.preventDefault()
      if !$('#save').prop("disabled")
        $('#save').click()

  window.keydown_event keydown

