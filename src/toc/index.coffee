import {first} from "panda-parchment"
import {Gadget, mixin, tag, bebop, shadow,
  render, properties, events, local,
  describe, resource, smart} from "@dashkite/carbon"

import {lookup} from "@dashkite/helium"
import {glob} from "@dashkite/hydrogen"

import template from "./template"

class extends Gadget

  mixin @, [

    tag "site-toc"

    bebop, shadow, describe #, navigate

    resource -> glob @cms, @description.glob

    getter cms: -> lookup @description.store ? "cms"

    render smart template

  ]
