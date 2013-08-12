_ = require "underscore"
noflo = require "noflo"

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

    @inPorts.in.on "begingroup", (group) =>
      @outPorts.out.beginGroup group

    @inPorts.in.on "data", (object) =>
      @objects.push object

    @inPorts.in.on "endgroup", (group) =>
      @flush()
      @outPorts.out.endGroup()

    @inPorts.in.on "disconnect", =>
      @flush()
      @outPorts.out.disconnect()

  flush: ->
    return if _.isEmpty @objects
    @outPorts.out.send _.groupBy @objects, @property
    @objects = []

exports.getComponent = -> new GroupBy
