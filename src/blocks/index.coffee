import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, getter, smart} from "@dashkite/carbon"

import {lookup} from "@dashkite/helium"
import {glob} from "@dashkite/hydrogen"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "site-blocks"

    bebop, shadow, describe #, navigate

    resource -> glob @cms, @dom.dataset.glob

    getter cms: -> lookup @description.store ? "cms"

    render smart template

  ]
