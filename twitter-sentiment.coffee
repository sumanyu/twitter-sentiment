# ---
# Uses Rickshaw, jQuery
# ---

class TwitterSentimentGraph

  constructor: (@element) ->
    @_setup()

  _setup: ->
    # size of the drawing area inside the svg's to make
    # the bar charts
    @width = 800
    @height = 400

    # @margin = 
    #   top: 20
    #   bottom: 20
    #   left: 40
    #   right: 60

    # @graphWidth = @width - @margin.left - @margin.right
    # @graphHeight = @height - @margin.top - @margin.bottom

    # # time scale
    # @xScale = d3.time.scale()
    #   .range([0, @graphWidth])

    # # emotion scale
    # @yScale = d3.scale.linear()
    #   .range([0, @graphHeight])

    @data = []

  _populateFakeData: ->
    for i in [0..30]
      tmp = 
        x: (new Date).getTime() + i*100
        y: Math.floor(Math.random() * 6) - 3

      @data.push(tmp)

  _sampleData: ->
    for i in [0..30]
      tmp = 
        x: i
        y: Math.floor(Math.random() * 6) - 3

      @data.push(tmp) 

  _setData: ->
    @_populateFakeData()
    # @_sampleData()

  _setAxis: ->
    @xAxis = new Rickshaw.Graph.Axis.Time( graph: @graph )

    # console.log Rickshaw.Fixtures.Number.formatKMBT

    config = 
      graph: @graph
      orientation: 'left'
      tickFormat: Rickshaw.Fixtures.Number.formatKMBT
      element: $('#y_axis')[0]

    @yAxis = new Rickshaw.Graph.Axis.Y(config)

  drawGraph: ->
    @_setData()

    construction = 
      element: @element
      height: @height
      width: @width
      min: 'auto'
      series:[
        color: 'steelblue'
        data: @data
      ]

    @graph = new Rickshaw.Graph(construction)

    @_setAxis()

    @graph.render()

  # _updateGraph: ->

  # _setAxis: ->
  #   xAxis = d3.svg.axis()
  #   .scale(@xScale)
  #   .orient("bottom");

  #   yAxis = d3.svg.axis()
  #   .scale(@yScale)
  #   .orient("left");

$(document).ready ->

  twitter_sentiment_graph = new TwitterSentimentGraph($("#graph")[0])
  twitter_sentiment_graph.drawGraph()
