# Path Helpers

I moved from [Iron Router](http://github.com/iron-meteor/iron-router) to FlowRouter and missed some of the helpers.

I implemented those helpers in this package allowing their use with any future router implementations.

Some of the helpers require a path generating implementation. This package allows its users to provide path generation to it.

I made a package which uses FlowRouter for path generation (it doesn't have these helpers builtin).

Iron Router has these helpers and its own path generating ability. (It doesn't have the isPath helpers, but zimme:iron-router-active provides them to Iron Router).


## Available Implementations

1. FlowRouter -> [cosmos:flow-router-path-helpers](http://github.com/elidoran/cosmos-flow-router-path-helpers)

```
    meteor add cosmos:flow-router-path-helpers
```

It would be possible to provide path generation in this package similar to FlowRouter, however, I chose to make use of their implementation instead of making my own.

## Helpers

### Similar to Iron Router

1. pathFor
2. urlFor
3. linkTo

The difference is there are no named routes. This supports FlowRouter which has no named routes. You must specify the path pattern instead. 


### Similar to [zimme:iron-router-active](https://github.com/zimme/meteor-iron-router-active)

1. isPath
2. isPathNot

These do not require a router implementation. They use `windows.location`.

Usage is similar to [zimme:iron-router-active](https://github.com/zimme/meteor-iron-router-active). The differences:

1. no 'Active' in the name
2. the "not" name has it as a suffix so it reads horizontally like: 

    `{{isPathNot path='/some/where'}}`
    
3. can specify a `regex` value *or* a `path` value


## Usage: pathFor / urlFor / linkTo

`pathFor` and `urlFor` both produce a string from a `path` pattern and optional extras: `params`, `query`, and `anchor`.

I used `anchor` instead of `hash` because Blaze stores the data provided to helpers using key `hash` and I wanted to avoid similar names.

`pathFor` is a relative path and `urlFor` is an absolute path.

If we have these optional extras provided by our template helper:
``` coffeescript
# CoffeeScript
Template.things.helpers
  getParams: -> {id: '12345'}
  getQuery:  -> {display: 'brief', extras: 10}
```
``` javascript
// JavaScript
Template.things.helpers({
  getParams: function() { 
    return {id: '12345'};
  },
  getQuery: function() {
    return {display: 'brief', extras: 10};
  }
});
```

Then this:
```
{{ pathFor path='/things/:id' params=getParams query=getQuery anchor='hashFrag'}}
```
Produces:
```
/things/12345?dislpay=brief&extras=10#hashFrag
```
`urlFor` uses `Meteor.absoluteUrl` to produce:
```html
http://yourhost:port/things/12345?dislpay=brief&extras=10#hashFrag
```

`linkTo` accepts content and produces an anchor element. This:
```html
{{#linkTo path='/items/:id' params=getParams query=getQuery anchor='hashFrag'}}
  <span style="color:blue;">
    Item
  </span>
{{#/linkTo}}
```
Produces:
```html
<a href="/items/12345?display=brief&extras=10#hashFrag">
  <span style="color:blue;">
    Item
  </span>
</a>
```

## Usage: isPath / isPathNot

### Attribute Use

`isPath` returns `active`, or the specified `className`, when the path matches; otherwise it returns **false** and the helper leaves the attribute blank.

`isPathNot` returns `disabled`, or the specified `className`, when the path *doesn't* match; otherwise it returns **false** and the helper leaves the attribute blank.

```html
<li class="{{isPath path='/home'}}">Home</li>
<li class="{{isPath regex='/profile|/options'}}">User</li>

```


### Conditional Use

Use them with `{{#if}}` in templates to control content
```html
{{#if isPath path='/home'}}
  <div>some content</div>
{{/if}}
```


## How to implement in your app or package?

A (simplified) example implementation using FlowRouter:
```coffeescript
# CoffeeScript:
PathHelpers.path = (options) ->
  FlowRouter.path options.path, options?.params, options?.query
```
```javascript
// JavaScript:
PathHelpers.path = function flowRouterPath(options) {
  return FlowRouter.path(options.path, options.params, options.query);
};
```

## Possible: Router agnostic implementation

The path conversion code doesn't need to be linked to a router implementation. I used the already made ability of FlowRouter to generate the paths because I'm using FlowRouter.

If someone provided router agnostic code which performs similar to `FlowRouter.path` then it could be combined with this package and used with any router (except Iron Router which implements these helpers in its own way).

