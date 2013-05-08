_ = require("underscore")
_s = require("underscore.string")
noflo = require("noflo")

class GroupBy extends noflo.Component

  description: "`groupBy` in Underscore.js"

  constructor: ->
    @inPorts =
      in: new noflo.Port
      property: new noflo.Port
    @outPorts =
      out: new noflo.Port

    @inPorts.property.on "data", (@property) =>

    @inPorts.in.on "connect", =>
      @objects = []

    @inPorts.in.on "data", (object) =>
      @objects.push object

    @inPorts.in.on "disconnect", =>
      @outPorts.out.send _.groupBy @objects, @property
      @outPorts.out.disconnect()

exports.getComponent = -> new GroupBy
