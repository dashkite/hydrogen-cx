import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, getter, smart} from "@dashkite/carbon"

import {lookup} from "@dashkite/helium"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "site-block"

    bebop, shadow, describe #, navigate

    resource -> find @cms, @dom.dataset.key

    getter cms: -> lookup @description.store ? "cms"

    render smart template

  ]
