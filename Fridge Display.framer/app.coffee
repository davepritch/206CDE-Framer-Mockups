# Set Background
background = new BackgroundLayer
	image: "images/background.png"

# Variables
gap = 50

# Forecast box variables
rows = 8
gutter = 30
rowWidth = 849
rowHeight = 240
item_list = ["images/items/item_1.png","images/items/item_2.png","images/items/item_3.png","images/items/item_4.png","images/items/item_5.png","images/items/item_6.png","images/items/item_7.png","images/items/item_8.png"]

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
confirm = new Layer
	image: "images/confirm.png"
	x: calendar.width  + (gap * 1) + (gap * 1)
	y: clock.height + weather.height + forecast_box.height + (gap * 4)
	width: forecast_box.width
	height: 91
forecast_scroll = new ScrollComponent
	x: calendar.width + (gap * 2)
	y: clock.height + weather.height + (gap * 3)
	width: forecast_box.width
	height: forecast_box.height
	scrollHorizontal: false
forecast_scroll.contentInset = 
	bottom: gap
forecast_label = new Layer
	html: "Shopping forecast"
	fontFamily: "HanziPen TC"
	color: 'white'
	parent: forecast_scroll.content
	backgroundColor: "rgba(0,0,0,0)"
	width: forecast_box.width
	opacity: 0.75
	y: 60
textStyle = { "text-align":"center", "font-size":"53px"}
forecast_label.style = textStyle

cancel = new Layer
	image: "images/cancel.png"
	width: 249
	height: 91
	x: calendar.width + (gap * 2)
	y: Screen.height - 91 - gap
	opacity: 0
arrive_tomorrow = new Layer
	image: "images/arriving_tomorrow.png"
	width: 675
	height: 91
	x: calendar.width + cancel.width + (gap * 2) + (gap / 2)
	y: Screen.height - 91 - gap
	opacity: 0

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
		image: item_list[index]
		width: rowWidth
		height: rowHeight
		x: gap
		y: 0
		parent: item_swipe.content

# Confirming and Cancelling touch events
confirm_handler = (event, layer) ->
    confirm.opacity = 0
    arrive_tomorrow.opacity = 1
    cancel.opacity = 1
    cancel.y = Screen.height - 91 - gap # Return to correct position
    cancel.on(Events.Click, cancel_handler)
    confirm.off(Events.Click, confirm_handler)
cancel_handler = (event, layer) ->
    confirm.opacity = 1
    arrive_tomorrow.opacity = 0
    cancel.opacity = 0
    cancel.y = Screen.height # Move out of way to prevent blocking touches to confirm
    cancel.off(Events.Click, cancel_handler)
    confirm.on(Events.Click, confirm_handler)
confirm.on(Events.Click, confirm_handler)