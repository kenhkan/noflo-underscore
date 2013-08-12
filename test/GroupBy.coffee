test = require "noflo-test"

process.on 'uncaughtException', (err) ->
  console.log('Caught exception: ' + err)

test.component("underscore/GroupBy").
  discuss("send some objects without defining a property to group by").
    send.connect("in").
      send.data("in", 1).
      send.data("in", 2).
      send.data("in", 3).
    send.disconnect("in").
  discuss("get back the objectified version (according to _.groupBy)").
    receive.connect("out").
      receive.data("out", { "1": [1], "2": [2], "3": [3] }).
    receive.disconnect("out").

  next().
  discuss("send in a property to group by length").
    send.connect("property").
      send.data("property", "length").
    send.disconnect("property").
    send.connect("in").
      send.data("in", "a").
      send.data("in", "bc").
      send.data("in", "de").
    send.disconnect("in").
  discuss("grouped by the length of the items").
    receive.connect("out").
      receive.data("out", { "1": ["a"], "2": ["bc", "de"] }).
    receive.disconnect("out").

  next().
  discuss("send in a callback function to check parity").
    send.connect("property").
      send.data("property", (num) -> num % 2).
    send.disconnect("property").
    send.connect("in").
      send.data("in", 1).
      send.data("in", 2).
      send.data("in", 3).
      send.data("in", 4).
      send.data("in", 5).
      send.data("in", 6).
    send.disconnect("in").
  discuss("grouped by the parity of the numbers").
    receive.connect("out").
      receive.data("out",
        "0": [2,4,6],
        "1": [1,3,5]
      ).
    receive.disconnect("out").

export module
