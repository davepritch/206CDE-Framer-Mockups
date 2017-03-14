# Set background
background = new BackgroundLayer
	image: "images/background.png"

# Variables
gap = 50

# Shopping forecast variables
rows = 8
gutter = 30
rowWidth = 849
rowHeight = 240

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

# Create ScrollComponent
scroll = new ScrollComponent
	width: 650
	height: 1005
	x: Align.center
	y: status_bar.height + gap + 10
	image: "images/container.png"
	scrollHorizontal: false
	borderRadius: 10

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
for i in [0...6]
	layer = new Layer
		parent: scroll.content
		name: "Row #{i}"
		width: 260
		height: 80
		x: 20
		y: 100 * i
		backgroundColor: "#FFF"
		borderRadius: 6

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