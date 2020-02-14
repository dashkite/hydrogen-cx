import {Gadget, mixin, tag, bebop, shadow,
  render, properties, getter, events,
  describe, resource, queryable, smart} from "@dashkite/carbon"
import {dashed} from "panda-parchment"
import {identity} from "panda-garden"

import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"

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

    tag "hydrogen-wikitext"

    bebop, describe, shadow, queryable #, navigate

    resource -> Store.links @cms, markup @html, await @data

    getter
      data: -> Store.get @cms, index: "path", key: @description.path ? {}
      script: -> @dom.querySelector "script"
      type: -> @script.getAttribute "type"
      transform: -> if @type == "text/markdown" then markdown else identity
      html: -> @transform @script.text
      cms: -> Registry.get @description.store ? "cms"

    render smart template

    events
      render: ->
        for e in @query.elements["[class^='language']"]
          Prism.highlightElement e

  ]
