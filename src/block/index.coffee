import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, getter, smart} from "@dashkite/carbon"

import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "hydrogen-block"

    bebop, shadow, describe #, navigate

    resource -> Store.find @cms, @dom.dataset.key

    getter cms: -> Registry.get @description.store ? "cms"

    render smart template

  ]
