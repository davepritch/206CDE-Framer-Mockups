background = new BackgroundLayer
	image: "images/background.png"

# Variables
gap = 50

# Forecast box variables
rows = 8
gutter = 30
rowWidth = 849
rowHeight = 240

# Placeholders

reminders = new Layer
	image: "images/reminders.png"
	x: gap
	y: gap
	width: 949
	height: 1291

calendar = new Layer
	image: "images/calendar.png"
	x: gap
	y: reminders.height + (gap * 2)
	width: 949
	height: 1291

clock = new Layer
	image: "images/clock.png"
	x: reminders.width + (gap * 2)
	y: gap
	width: 949
	height: 441

weather = new Layer
	image: "images/weather.png"
	x: reminders.width + (gap * 2)
	y: clock.height + (gap * 2)
	width: 949
	height: 800

# Shopping Forecast

forecast_box = new Layer
	image: "images/shopping_forecast_box.png"
	x: calendar.width + (gap * 2)
	y: reminders.height + (gap * 2)
	width: 949
	height: 1150

cancel = new Layer
	image: "images/cancel.png"
	x: calendar.width + (gap * 2)
	y: clock.height + weather.height + forecast_box.height + (gap * 4)
	width: 249
	height: 91

confirm = new Layer
	image: "images/confirm.png"
	x: calendar.width + cancel.width + (gap * 3)
	y: clock.height + weather.height + forecast_box.height + (gap * 4)
	width: 650
	height: 91

forecast_scroll = new ScrollComponent
	x: calendar.width + (gap * 2)
	y: clock.height + weather.height + (gap * 3)
	width: forecast_box.width
	height: forecast_box.height
	scrollHorizontal: false

forecast_scroll.contentInset = 
	bottom: gap

textStyle = { "padding-left":"30px", "font-size":"50px"}

forecast_label = new Layer
	html: "Shopping forecast"
	fontFamily: "HanziPen TC"
	color: 'white'
	parent: forecast_scroll.content
	backgroundColor: "rgba(0,0,0,0)"
	width: forecast_box.width
	y: 60

forecast_label.style = textStyle

# Loop to create row layers
for index in [0...rows]
	item_swipe = new ScrollComponent
		width: forecast_box.width
		height: rowHeight
		x: 0
		y:150 + index * (rowHeight + gutter)
		parent: forecast_scroll.content
		scrollVertical: false
	item_swipe.contentInset =
		right: 300
	item_swipe.content.draggable.directionLock = true
	item_swipe.content.draggable.directionLockThreshold =
		x: 0
		y: 10
	cell = new Layer
		image: "images/item_box.png"
		width: rowWidth
		height: rowHeight
		x: gap
		y: 0
		parent: item_swipe.content