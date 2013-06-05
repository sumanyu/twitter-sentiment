# ---
# Uses Rickshaw, jQuery
# ---

class TwitterSentimentGraph

  constructor: (@element) ->
    @_setup()

  _setup: ->
    # size of the drawing area inside the svg's to make
    # the bar charts
    @width = 600
    @height = 300

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
        x: (new Date).getTime()
        y: Math.floor(Math.random() * 6) - 3

      @data.push(tmp)

  _setData: ->
    @_populateFakeData()

  drawGraph: ->
    @_setData()

    construction = 
      element: @element
      height: @height
      width: @width
      series:[
        color: 'steelblue'
        data: @data
      ]

    graph = new Rickshaw.Graph(construction)

    graph.render()

  # _updateGraph: ->

  # _setAxis: ->
  #   xAxis = d3.svg.axis()
  #   .scale(@xScale)
  #   .orient("bottom");

  #   yAxis = d3.svg.axis()
  #   .scale(@yScale)
  #   .orient("left");

$(document).ready ->
  twitter_sentiment_graph = new TwitterSentimentGraph(document.querySelector("#graph"))
  twitter_sentiment_graph.drawGraph()
