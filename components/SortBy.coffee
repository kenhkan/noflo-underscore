noflo = require 'noflo'
_ = require 'underscore'

class SortBy extends noflo.Component

  description: 'Sorts IPs by <property>, sends sorted IPs on disconnect or endgroup. Order can be <desc> or <asc>(default)'
  buffer: []
  attribute: null
  order: 1

  constructor: ->
    @inPorts =
      in: new noflo.Port
      property: new noflo.Port
      order: new noflo.Port

    @outPorts =
      out: new noflo.Port

    @inPorts.property.on "data", (@attribute) =>

    @inPorts.order.on "data", (direction) =>
      @order = (if direction is 'desc' then -1 else 1)

    @inPorts.in.on "connect", =>
      @buffer = []

    @inPorts.in.on "begingroup", (group) =>
      @outPorts.out.beginGroup group

    @inPorts.in.on "data", (object) =>
      @buffer.push object

    @inPorts.in.on "endgroup", (group) =>
      @flush()
      @outPorts.out.endGroup()

    @inPorts.in.on "disconnect", =>
      @flush()
      @outPorts.out.disconnect() if @outPorts.out.isAttached()

  flush: ->
    return if _.isEmpty @buffer
    sorted = _.sortBy @buffer, ((ip) -> Number(ip[@attribute] * @order) or 0), this
    for ip in sorted
      @outPorts.out.send ip
    @buffer = [];

exports.getComponent = -> new SortBy