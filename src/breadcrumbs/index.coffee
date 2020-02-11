import {split} from "panda-parchment"

import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, smart} from "@dashkite/carbon"

import {lookup as registryLookup} from "@dashkite/helium"
import {find, lookup} from "@dashkite/hydrogen"

import template from "./template"

join = (string, array) -> array.join string
parent = (path) ->
  components = split "/", path
  components.pop()
  if components.length > 1
    join "/", components

class extends Gadget

  mixin @, [

    tag "site-breadcrumbs"

    bebop, shadow, describe #, navigate

    resource ->
      path = @dom.dataset.path
      crumbs = []
      current = @dom.dataset.current ? (await lookup @cms, "path", path)?.title
      while (path = parent path)?
        if (target = await lookup @cms, "path", path)?
          crumbs.unshift target
      {crumbs, current}

    getter cms: -> registryLookup @description.store ? "cms"

    render smart template

  ]
