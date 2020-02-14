import {split} from "panda-parchment"

import {Gadget, mixin, tag, bebop, shadow,
  render, properties, getter, events, local,
  describe, resource, smart} from "@dashkite/carbon"

import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"

import template from "./template"

join = (string, array) -> array.join string
parent = (path) ->
  components = split "/", path
  components.pop()
  if components.length > 1
    join "/", components

class extends Gadget

  mixin @, [

    tag "hydrogen-breadcrumbs"

    bebop, shadow, describe #, navigate

    resource ->
      path = @description.path
      crumbs = []
      current = @description.current ?
        (await Store.get @cms, "path", path)?.title
      while (path = parent path)?
        if (target = await Store.get @cms, "path", path)?
          crumbs.unshift target
      {crumbs, current}

    getter cms: -> Registry.get @description.store ? "cms"

    render smart template

  ]
