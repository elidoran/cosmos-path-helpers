
// Must use a JS file to export objects in Meteor. Doing it in CS is convoluted.
// export this object so other packages can alter the path function to their own
// implementation

PathHelpers = {
  path: function defaultPathImpl(options) {
    throw new Error("Implement PathHelpers.path, or use package cosmos:flow-router-path-helpers");
  }
};
