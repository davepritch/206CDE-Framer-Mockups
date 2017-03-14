# Set background
background = new BackgroundLayer
	image: "images/background.png"

# Variables
gap = 50

# Shopping forecast variables
rows = 8
gutter = 30
rowWidth = 566
rowHeight = 201
item_list = ["images/items/item_1.png","images/items/item_2.png","images/items/item_3.png","images/items/item_4.png","images/items/item_5.png","images/items/item_6.png","images/items/item_7.png","images/items/item_8.png"]

# status bar
status_bar = new Layer
	image: "images/status_bar.png"
	width: 728
	height: 24
	x: Align.center
	y: 10

# tab bar
tab_bar = new Layer
	image: "images/tab_bar_components/tab_bar.png"
	width: Screen.width
	height: 98
	x: Align.center
	y: Screen.height - 98

# Create Scroll Box
forecast_scroll = new ScrollComponent
	width: 650
	height: 1005
	x: Align.center
	y: status_bar.height + gap + 10
	image: "images/container.png"
	scrollHorizontal: false
	borderRadius: 40
forecast_scroll.contentInset = 
	top: gap
	bottom: gap

# Create confirm button
confirm = new Layer
	image: "images/confirm.png"
	width: 650
	height: 97
	x: Align.center
	y: Screen.height - tab_bar.height - 97 - (gap * 0.5)

cancel = new Layer
	image: "images/cancel.png"
	width: 202
	height: 97
	x: gap
	y: Screen.height - tab_bar.height - 97 - (gap * 0.5)
	opacity: 0
arrive_tomorrow = new Layer
	image: "images/arriving_tomorrow.png"
	width: 423
	height: 97
	x: cancel.width + (gap * 1.5)
	y: Screen.height - tab_bar.height - 97 - (gap * 0.5)
	opacity: 0

# Add top and bottom inset
scroll.contentInset =
	top: 20
	bottom: 20

# Add layers
for i in [0...rows]
	item_swipe = new ScrollComponent
		width: forecast_scroll.width
		height: rowHeight
		x: 0
		y: i * (rowHeight + gutter)
		parent: forecast_scroll.content
		scrollVertical: false
	item_swipe.contentInset =
		right: 250
	item_swipe.content.draggable.directionLock = true
	item_swipe.content.draggable.directionLockThreshold =
		x: 0
		y: 10
	cell = new Layer
		image: item_list[i]
		width: rowWidth
		height: rowHeight
		x: Align.center
		y: 0
		parent: item_swipe.content

# Confirming and Cancelling touch events
confirm_handler = (event, layer) ->
    confirm.opacity = 0
    arrive_tomorrow.opacity = 1
    cancel.opacity = 1
    cancel.y = Screen.height - tab_bar.height - 97 - (gap * 0.5) # Return to correct position
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