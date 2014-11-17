# keydown event
window.keydown_event = (fn) ->
  if document.addEventListener
    document.addEventListener("keydown", fn, false)
  else if document.attachEvent
    document.attachEvent("onkeydown", fn)
  else
    document.onkeydown = fn

# show message
window.show_message = (state, message)->
  if "success" == state
    $('#message_box').removeClass("eroor_message").addClass("success_message").text(message).fadeIn(300)
  else if "error" == state
    $('#message_box').removeClass("success_message").addClass("error_message").text(message).fadeIn(300)
  setTimeout -> 
    $('#message_box').fadeOut()
  , 2000

# markdown to html
window.markdown = (text, target) ->
  marked.setOptions
    langPrefix: ''
  mark = marked escapeHTML text
  target.html mark
  target.find('pre code').each (i, e) ->
    e.textContent = unescapeHTML e.textContent
    hljs.highlightBlock e, e.className

# HTML escape, unescape
escapeHTML = (html) ->
  $('<div>').text(html).html()
unescapeHTML = (text) ->
  $('<div>').html(text).text()

# change menu active
window.menu_active = (menu, target) ->
  menu.find("[id^=menu-]").removeClass("active")
  menu.find("#menu-" + target).addClass("active")

# get today
window.today = ->
  now  = new Date();
  y = now.getFullYear();
  m = now.getMonth()+1;
  d = now.getDate();
  y + "/" + m + "/" + d + " "

window.beforeunload = (isChanged) ->
  if isChanged
    $(window).bind "beforeunload", ->
      return "入力中の内容が破棄されますがよろしいですか？"
  else
    $(window).unbind "beforeunload"
