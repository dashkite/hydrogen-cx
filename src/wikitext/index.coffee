import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events,
  describe, resource, queryable, smart} from "panda-play"
import {dashed} from "panda-parchment"

import {lookup as registryLookup} from "@dashkite/helium"
import {lookup, links} from "@dashkite/hydrogen"

import template from "./template"

markup = do ({filters, apply, key} = {}) ->
  apply = do (filters = {dashed}) ->
    (value, name) -> filters[name] value
  (string, context = {}) ->
    string.replace /\{\{([\s\S]+)\}\}/g, (_, directive) ->
      [key, filters...] = directive.split("|").map (s) -> s.trim()
      filters.reduce apply, context[key]

class extends Gadget

  mixin @, [

    tag "site-wikitext"

    bebop, describe, shadow, queryable #, navigate

    resource -> links markup @html, await @data

    getter
      data: -> lookup "path", @description.path ? {}
      script: -> @dom.querySelector "script"
      type: -> @script.getAttribute "type"
      html: ->
        if @type == "text/markdown" then markdown @script.text else @script.text
      cms: -> registryLookup @description.store ? "cms"

    render smart template

    events
      render: ->
        for e in @query.elements["[class^='language']"]
          Prism.highlightElement e

  ]
