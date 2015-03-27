####################################
# Helpers: pathFor, urlFor, linkTo #
####################################

# Returns a relative path based on the provided options:
#  path   : the path, optionally with params such as: /path/:id
#  params : the values for the params in path, such as {id: '1234'}
#  query  : the query keys/values to add
#  anchor : the hash fragment string
@pathFor = (options) ->

  if options?.hash? then options = options.hash

  unless options?.path?
    msg = 'pathFor requires a \'path\' option'
    console.log msg
    throw new Error msg

  path = PathHelpers.path options

# Returns an absolute path based on the provided options:
#  path   : the path, optionally with params such as: /path/:id
#  params : the values for the params in path, such as {id: '1234'}
#  query  : the query keys/values to add
#  anchor : the hash fragment string
urlFor = (options) ->
  # TODO: support sending options to Meteor.absolute
  Meteor.absoluteUrl pathFor options

# Returns an object containing the key/value pairs for an A element
# used by renderLinkTo
@linkToAttributes = (options) ->
  attributes = _.omit options, 'path', 'params', 'query', 'anchor'
  attributes.href = pathFor options
  attributes

# gets the parent's data
# used by renderLinkTo
# [Code Snippet taken from Iron Router]
@getInclusionArguments = (view) ->

  parent = view?.parentView

  if not parent? then return null

  if parent?.__isTemplateWith?
    return parent.dataVar.get()

  return null

# gets the data context for the view
# used by renderLinkTo
# [Code Snippet taken from Iron Router]
@getDataContext = (view) ->
  while view
    if view.name is 'with' and not view.__isTemplateWith?
      return view.dataVar.get()
    else
      view = view.parentView

  return view

# Renders the A element for a Blaze.Template
# used by linkToTemplate
renderLinkTo = ->
  self = this
  options = getInclusionArguments self
  attributes = linkToAttributes options
  context = -> getDataContext self
  content = -> HTML.A(attributes, self.templateContentBlock)
  return Blaze.With context, content

# A Blaze Template which renders an A element containing wrapped content
# and with with a relative path href based on the provided options:
#  path   : the path, optionally with params such as: /path/:id
#  params : the values for the params in path, such as {id: '1234'}
#  query  : the query keys/values to add
#  anchor : the hash fragment string
linkToTemplate = new Blaze.Template 'eliLinkTo', renderLinkTo

#
# Now register the three helpers
#
Template.registerHelper 'pathFor', pathFor
Template.registerHelper 'urlFor', urlFor
Template.registerHelper 'linkTo', linkToTemplate
