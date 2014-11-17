# get device
window.get_device = ->
  ua = navigator.userAgent
  if (ua.indexOf('iPhone') > 0 || ua.indexOf('iPod') > 0 || ua.indexOf('Android') > 0 && ua.indexOf('Mobile') > 0)
    return 'sp'
  else if (ua.indexOf('iPad') > 0 || ua.indexOf('Android') > 0)
    return 'tab'
  else
    return 'other'

window.isPc = ->
  get_device() == "other"

window.isTablet = ->
  get_device() == "tablet"

window.isSmart = ->
  get_device() == "sp"

window.isTooltip = ->
  isPc() && "true" == $("#config-keyshortcut").val()
