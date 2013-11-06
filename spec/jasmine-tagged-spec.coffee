require '../lib/jasmine-tagged'

describe "jasmine-tagged", ->
  [env, taggedSpec, multiTaggedSpec, anotherTaggedSpec, untaggedSpec] = []

  beforeEach ->
    env = jasmine.getEnv()
    taggedSpec =
      description: '#tag'
    multiTaggedSpec =
      description: '#tag #another-tag'
    anotherTaggedSpec =
      description: '#another-tag'
    untaggedSpec =
      description: 'no tag'

  describe "by default", ->
    it "runs untagged specs", ->
      expect(env.specFilter(untaggedSpec)).toBeTruthy()

    it "doesn't run any tagged specs", ->
      expect(env.specFilter(taggedSpec)).toBeFalsy()

  describe "without untagged specs", ->
    beforeEach ->
      env.includeSpecsWithoutTags(false)

    afterEach ->
      env.includeSpecsWithoutTags(true)

    it "doesn't run untagged specs", ->
      expect(env.specFilter(taggedSpec)).toBeFalsy()

  describe "with a specific tag specs", ->
    beforeEach ->
      env.setIncludedTags(['tag'])

    afterEach ->
      env.setIncludedTags([])

    it "run specs with a matching tag", ->
      expect(env.specFilter(taggedSpec)).toBeTruthy()
      expect(env.specFilter(multiTaggedSpec)).toBeTruthy()

    it "doesn't run specs with different tags", ->
      expect(env.specFilter(anotherTaggedSpec)).toBeFalsy()

  describe "with a nested spec", ->
    [nestedTaggedSpec, nestedAnotherTaggedSpec] = []

    beforeEach ->
      env = jasmine.getEnv()
      suite =
        description: 'another level'
      nestedTaggedSpec =
        description: '#tag'
        parentSuite: suite
      nestedAnotherTaggedSpec =
        description: '#another-tag'
        parentSuite: suite

    describe "with a specific tag specs", ->
      beforeEach ->
        env.setIncludedTags(['tag'])

      afterEach ->
        env.setIncludedTags([])

      it "run specs with a matching tag", ->
        expect(env.specFilter(nestedTaggedSpec)).toBeTruthy()

      it "doesn't run specs with different tags", ->
        expect(env.specFilter(nestedAnotherTaggedSpec)).toBeFalsy()

  describe "with a tagged suite", ->
    [taggedSuiteSpec] = []

    beforeEach ->
      env = jasmine.getEnv()
      suite =
        description: 'another #tag'
      taggedSuiteSpec =
        description: 'no tag'
        suite: suite

    describe "with a specific tag specs", ->
      beforeEach ->
        env.includeSpecsWithoutTags(false)
        env.setIncludedTags(['tag'])

      afterEach ->
        env.includeSpecsWithoutTags(true)
        env.setIncludedTags([])

      it "run specs with a matching tag", ->
        expect(env.specFilter(taggedSuiteSpec)).toBeTruthy()
