import {dashed} from "panda-parchment"
import {identity} from "panda-garden"
import {Gadget, mixin, tag, bebop, shadow,
  render, properties, getter, events, local,
  describe, resource, queryable, smart} from "@dashkite/carbon"
import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"
import template from "./template"
import marked from "marked"
import Prism from "prismjs"

markdown = (text) ->
  marked text,
    smartypants: true
    gfm: true

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

    bebop, describe, shadow, queryable

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
      render: local ->
        for e in @query.elements["[class^='language']"]
          Prism.highlightElement e

  ]
