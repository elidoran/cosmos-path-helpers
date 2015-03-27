
pathRequiredMessage = 'pathFor requires a \'path\' option'

Tinytest.add 'pathFor: undefined ~ error', (test) ->
  options = undefined
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage

Tinytest.add 'pathFor: null ~ error', (test) ->
  options = null
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage

Tinytest.add 'pathFor: empty ~ error', (test) ->
  options = {}
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage

Tinytest.add 'pathFor: hash:undefined ~ error', (test) ->
  options = {hash: undefined}
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage

Tinytest.add 'pathFor: hash:null ~ error', (test) ->
  options = {hash: null}
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage

Tinytest.add 'pathFor: hash:empty ~ error', (test) ->
  options = {hash: {}}
  try
    path = pathFor options
  catch e
    error = e.message

  test.equal error, pathRequiredMessage
