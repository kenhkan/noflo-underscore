test = require "noflo-test"

process.on 'uncaughtException', (err) ->
  console.log('Caught exception: ' + err)

test.component("underscore/SortBy").
  discuss("send some objects with property score in").
    send.connect("property").
      send.data("property", "score").
    send.disconnect("property").
    send.connect("in").
      send.data("in", {name: 'second', "score": 5}).
      send.data("in", {name: 'third', "score": 10}).
      send.data("in", {name: 'first', "score": 2}).
    send.disconnect("in").
  discuss("get back ordered by score").
    receive.connect("out").
      receive.data("out", {name: 'first', score: 2}).
      receive.data("out", {name: 'second', score: 5}).
      receive.data("out", {name: 'third', score: 10}).
    receive.disconnect("out").

  next().
  discuss("send some objects and order desc").
    send.connect("property").
      send.data("property", "score").
    send.disconnect("property").
    send.connect("order").
      send.data("order", "desc").
    send.disconnect("order").
    send.connect("in").
      send.data("in", {name: 'first', "score": 15}).
      send.data("in", {name: 'second', "score": 3}).
      send.data("in", {name: 'third', "score": 1}).
    send.disconnect("in").
  discuss("get back ordered by score").
    receive.connect("out").
      receive.data("out", {name: 'first', score: 15}).
      receive.data("out", {name: 'second', score: 3}).
      receive.data("out", {name: 'third', score: 1}).
    receive.disconnect("out").

  next().
  discuss("send some objects and no number as score").
    send.connect("property").
      send.data("property", "score").
    send.disconnect("property").
    send.connect("in").
      send.data("in", {name: 'first', "score": 'a'}).
      send.data("in", {name: 'third', "score": '3'}).
      send.data("in", {name: 'second', "score": 1}).
    send.disconnect("in").
  discuss("get back ordered by score").
    receive.connect("out").
      receive.data("out", {name: 'first', score: 'a'}).
      receive.data("out", {name: 'second', score: 1}).
      receive.data("out", {name: 'third', score: 3}).
    receive.disconnect("out").

export module
