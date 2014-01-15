jasmine = require 'jasmine-focused'

env = jasmine.getEnv()

includeSpecsWithoutTags = true
env.includeSpecsWithoutTags = (permit) ->
  includeSpecsWithoutTags = permit

includedTags = []
env.setIncludedTags = (tags) ->
  includedTags = tags

findTags = (spec) ->
  words = spec.description.split(' ')
  tags = (word.substring(1) for word in words when word.indexOf('#') is 0)
  tags ?= []

  if parent = spec.parentSuite ? spec.suite
    tags.concat(findTags(parent))
  else
    tags

originalFilter = if env.specFilter then env.specFilter else -> true
env.specFilter = (spec) ->
  return false unless originalFilter(spec)

  tags = findTags(spec)
  return true if includeSpecsWithoutTags and tags.length is 0

  if tags.some((t) -> includedTags.some((it) -> it is t))
    true
  else
    false

module.exports = jasmine
