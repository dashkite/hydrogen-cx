import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, getter, smart} from "@dashkite/carbon"

import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "hydrogen-blocks"

    bebop, shadow, describe

    resource -> Store.glob @cms, @dom.dataset.glob

    getter cms: -> Registry.get @description.store ? "cms"

    render smart template

  ]
