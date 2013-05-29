test = require "noflo-test"

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
  discuss("send in a property to group by").
    send.connect("property").
      send.data("property", "length").
    send.disconnect("property").
  discuss("send some objects").
    send.connect("in").
      send.data("in", "a").
      send.data("in", "bc").
      send.data("in", "de").
    send.disconnect("in").
  discuss("grouped by the property of the items").
    receive.connect("out").
      receive.data("out", { "1": ["a"], "2": ["bc", "de"] }).
    receive.disconnect("out").

export module
