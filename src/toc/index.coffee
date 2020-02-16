import {first} from "panda-parchment"
import {Gadget, mixin, tag, bebop, shadow,
  render, properties, getter, events, local,
  describe, resource, smart} from "@dashkite/carbon"

import Store from "@dashkite/hydrogen"
import Registry from "@dashkite/helium"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "hydrogen-toc"

    bebop, shadow, describe

    resource -> Store.glob @cms, @description.glob

    getter cms: -> Registry.get @description.store ? "cms"

    render smart template

  ]
