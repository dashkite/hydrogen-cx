# TODO I don't really understand why this needs a require
p9k = require "panda-9000"

import {rmr} from "panda-quill"
import {go, map, wait, tee, reject} from "panda-river"
import coffee from "coffeescript"
import pug from "pug"
import _stylus from "stylus"
import markdown from "marked"
import vogue from "@dashkite/vogue"


{define, run, glob, read, write,
  extension, copy, transform, watch} = p9k

define "build", [ "clean", "html&", "js&"]

define "clean", -> rmr "build"

define "js", ->
  resolve = (path) ->
    require.resolve path, paths: [ process.cwd() ]

  go [
    glob [ "**/*.coffee" ], "./src"
    wait map read
    tee ({source, target}) ->
      target.content = coffee.compile source.content,
        bare: true
        inlineMap: true
        filename: source.path
        transpile:
          presets: [[
            resolve "@babel/preset-env"
            targets: node: "current"
          ]]
          plugins: [
            [ "prismjs",
                "languages": ["javascript", "coffee", "yaml"],
                # "plugins": ["line-numbers"],
                # "theme": "twilight",
                # "css": true
            ]
          ]
    map extension ".js"
    map write "./build"
  ]

define "html", ->
  go [
    glob [ "**/*.pug", "!**/-*/**", "!**/-*" ], "./src"
    wait map read
    tee ({source, target}) ->
      stylus = (code) ->
        _stylus.render code,
          use: vogue
          filename: source.path

      target.content = do ->
        code = pug.compileClient source.content,
          filename: source.path
          name: "f"
          filters: {stylus, markdown}
        "#{code}\n\nmodule.exports = f"
    map extension ".js"
    map write "./build"
  ]
