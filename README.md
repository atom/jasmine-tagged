##### Atom and all repositories under Atom will be archived on December 15, 2022. Learn more in our [official announcement](https://github.blog/2022-06-08-sunsetting-atom/)
 # Jasmine Tagged [![Build Status](https://travis-ci.org/atom/jasmine-tagged.svg?branch=master)](https://travis-ci.org/atom/jasmine-tagged)

Allows for tagging and filtering of specific
[Jasmine](https://github.com/pivotal/jasmine) specs depending on the
platform.

## Installing

```sh
npm install jasmine-tagged
```

## Building
  * Clone the repository
  * Run `npm install`
  * Run `grunt` to compile the CoffeeScript

## Using

```coffeescript
  describe "Javascript", ->
    describe "on the #server", ->
      it "can access files"
    describe "on the #browser", ->
      it "can access localstorage"
```

In jasmine-helper.js

```coffeescript
require 'jasmine-tagged'

jasmineEnv = jasmine.getEnv()
jasmineEnv.setIncludedTags(["browser"])

# By default untagged specs are run, uncomment to change that behavior
# jasmineEnv.includeSpecsWithoutTags(false)
```
