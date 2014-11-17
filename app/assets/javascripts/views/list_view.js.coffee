class Notie.Views.ListView extends Backbone.View
  el: '#view'
  template: JST["templates/notes/list"]

  initialize: ->
    window.beforeunload(false)
    @render()
    @addAll()

  events:
    "keyup #search-note" : "search"
    "click .tag" : "select_tag"
    "switchChange.bootstrapSwitch .settings" : "change_setting"

  addAll: ->
    @drow_list()
    @drow_tag_list()

  render: ->
    @$el.html @template
    @$el.find('#search-note').focus()
    $("[kind='shortcut']").bootstrapSwitch({size: "mini"})
    $("[kind='shortcut']").bootstrapSwitch('state', "true" == $("#config-keyshortcut").val() ? true : false)
    @

  unload: ->
    true

  search: (e)->
    if e.keyCode == 37 or e.keyCode == 38 or e.keyCode == 39 or e.keyCode == 40
      return
    @drow_list()
    @

  select_tag: (e)->
    $(e.target).toggleClass("selected")
    @drow_list()
    @

  drow_list: ->
    select_tags = _.filter (_.map $('.tag'), (tag) ->  $(tag).text() if $(tag).hasClass("selected")), (tag) -> tag
    select_text = $('#search-note').val().toLowerCase()
    that = @
    tagList = []
    $('table#note_list').html ""
    _.each @collection.models, (note) ->
      title = note.toJSON().title.toLowerCase()
      content = note.toJSON().content.toLowerCase()
      tags = note.toJSON().tag_list
      tags = tags.split(",") if typeof tags == "string"

      isDrow = false
      if 0 <= title.indexOf(select_text) or 0 <= content.indexOf(select_text)
        if select_tags.length == 0
          # all tag drow
          isDrow = true
        else
          # select tag drow
          _.each tags, (tag)->
            if _.contains select_tags, tag
              isDrow = true
      if isDrow
        that.addOne(note)
    @

  drow_tag_list: ->
    that = @
    tagList = []
    _.each @collection.models, (note) ->
      tags = note.toJSON().tag_list
      tags = tags.split(",") if typeof tags == "string"

      # get tag list
      _.each tags, (tag)->
        tagList.push(tag)

    # tag sort and unique
    tagList = _.sortBy(_.uniq(tagList), (tag) -> tag)
    tagDom = @$el.find('#tag-list')
    # tag list redrow
    tagDom.html ""
    _.each tagList, (tag)->
      tagDom.append($("<li/>").addClass("tag").text(tag))

    # add user-config taglist
    $("#config-taglist").val(tagList)

  addOne: (note) ->
    @view = new Notie.Views.NoteView({model: note})
    @$el.find('table#note_list').append @view.render().el

    showDOM = $("<td colspan='3'/>")
    markdown note.attributes.content, showDOM
    @$el.find('table#note_list').append $("<tr class='preview'/>").append(showDOM).hide()

  change_setting: (e, state)->
    $(e.target).parent().parent().after($(" <i class='fa fa-spinner fa-spin'>"))
    $.ajax
      url: "app/user/setting"
      type: "POST"
      data: {key_shortcut: state}
      success: (res)->
        $(e.target).parent().parent().next().remove()
        $("#config-keyshortcut").val(state).change()
      error: ->
        console.log "error!"
