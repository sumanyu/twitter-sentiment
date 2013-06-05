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
    @data = []

  _populateFakeData: ->
    for i in [0..30]
      tmp = 
        x: (new Date).getTime() + i*50
        y: Math.floor(Math.random() * 7) - 3

      @data.push(tmp)

  _rickShawData: ->
    @random = new Rickshaw.Fixtures.RandomData(100)

    for i in [0..100]
      @random.addData([@data])

  _sampleData: ->
    for i in [0..30]
      tmp = 
        x: i
        y: Math.floor(Math.random() * 6) - 3

      @data.push(tmp) 

  _setData: ->
    # @_populateFakeData()
    # @_sampleData()
    @_rickShawData()


  _setAxis: ->

    ticksTreatment = 'glow'

    @xAxis = new Rickshaw.Graph.Axis.Time( 
      graph: @graph 
      ticksTreatment: ticksTreatment
      ) 

    config = 
      graph: @graph
      orientation: 'left'
      tickFormat: Rickshaw.Fixtures.Number.formatKMBT
      element: $('#y_axis')[0]
      ticksTreatment: ticksTreatment

    @yAxis = new Rickshaw.Graph.Axis.Y(config)

  _setLegend: ->

    config =
      element: $("#legend")[0]
      graph: @graph

    @legend = Rickshaw.Graph.Legend(config)

  _setSlider: ->

    config =
      graph: @graph
      element: $("#slider")

    @slider = new Rickshaw.Graph.RangeSlider(config)

  _setHoverDetail: ->
    @hoverDetail = new Rickshaw.Graph.HoverDetail(graph: @graph)

  _scheduleUpdateData: ->

    fetch_data = =>
      @random.addData([@data])
      @graph.update()

    setInterval(fetch_data, 1000)

  drawGraph: ->
    @_setData()

    construction = 
      element: @element
      height: @height
      width: @width
      min: 'auto'
      stroke: true
      preserve: true
      series:[
        color: 'steelblue'
        name: 'Global'
        data: @data
      ]

    @graph = new Rickshaw.Graph(construction)

    @_setAxis()

    # @_setLegend()

    @_setSlider()

    @_setHoverDetail()

    @_scheduleUpdateData()

    @graph.render()

$(document).ready ->
  twitter_sentiment_graph = new TwitterSentimentGraph($("#graph")[0])
  twitter_sentiment_graph.drawGraph()
