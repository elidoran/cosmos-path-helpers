##############################
# Helpers: isPath, isPathNot #
##############################

getCurrentPath = ->
  fullPath = window.location.href
  if window.location?.origin
    originLength = window.location.origin.length
  else
    originLength = fullPath.substring(8).indexOf('/') + 8
  path = fullPath.substring originLength
  return path

getResult = (bool, options) ->

  # invert value if told to
  bool = not bool if options?.invert?

  # only return a string when result is true
  if bool
    if options?.className? then options?.className
    else if options?.invert? then 'disabled'
    else 'active'
  else
    false

isActive = (options) ->

  # pull our options out of the Spacebars.kw which is in 'hash'
  options = options.hash
  # get the current path from windows.location
  currentPath = getCurrentPath()

  # if we have a path, test that
  if options?.path?
    result = currentPath is options.path

  # if we have a regex, test that
  else if options?.regex?
    result = new RegExp(options.regex, 'i').test(currentPath)

  # otherwise result is false... TODO: check for path/regex up front
  else
    result = false

  # convert result to appropriate string or leave false
  result = getResult result, options

  return result

Template.registerHelper 'isPath', isActive
Template.registerHelper 'isPathNot', (options) ->
  options.hash.invert = true
  isActive options
