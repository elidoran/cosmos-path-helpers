
Tinytest.add 'PathHelpers is accessible', (test) ->
  test.equal true, PathHelpers?

Tinytest.add 'PathHelpers.path is accessible', (test) ->
  test.equal true, PathHelpers?.path?

Tinytest.add 'PathHelpers.path unimplemented throws error', (test) ->
  try
    PathHelpers.path()
  catch e
    errored = true
  test.equal errored, true

Tinytest.add 'PathHelpers.path can be set to new implementation', (test) ->
  msg = 'new path()'
  PathHelpers?.path = -> msg
  test.equal msg, PathHelpers?.path()
