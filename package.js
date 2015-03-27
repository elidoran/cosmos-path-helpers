Package.describe({
  name: 'cosmos:path-helpers',
  version: '0.1.0',
  summary: 'Base package for pathFor/urlFor/linkTo/isPath helpers',
  git: 'http://github.com/elidoran/cosmos-path-helpers.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.4.2');

  api.use([
      'templating',
      'coffeescript',
      'underscore'
    ], 'client'
  );

  api.addFiles([
    'lib/globalObject.js',
    'lib/linkPathHelpers.coffee',
    'lib/activePathHelpers.coffee'
    ], 'client'
  );

  api.export('PathHelpers', 'client');

});

Package.onTest(function(api) {
  api.use([
    'tinytest',
    'coffeescript',
    'cosmos:path-helpers'
  ], 'client');

  api.addFiles([
    'test/testPathOptionRequired.coffee',
    'test/testPathHelpers.coffee',
    'test/testActivePathHelpers.coffee'
  ], 'client');
});
