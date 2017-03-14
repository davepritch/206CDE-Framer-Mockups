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
tab_icon_1 = new Layer
	image: "images/tab_bar_components/tab_blue_1.png"
	width: 136
	height: 78
	x: 40
	y: Screen.height - tab_bar.height + 16
tab_icon_2 = new Layer
	image: "images/tab_bar_components/tab_grey_2.png"
	width: 92
	height: 82
	x: 250
	y: Screen.height - tab_bar.height + 12
tab_icon_3 = new Layer
	image: "images/tab_bar_components/tab_grey_3.png"
	width: 70
	height: 82
	x: 440
	y: Screen.height - tab_bar.height + 12
tab_icon_4 = new Layer
	image: "images/tab_bar_components/tab_grey_4.png"
	width: 82
	height: 82
	x: 620
	y: Screen.height - tab_bar.height + 12

# Create tab container (pages)
tab_container = new PageComponent
	x: Align.center
	width: 650
	height: Screen.height - tab_bar.height
	scrollVertical: false
	backgroundColor: "rgba(50,50,200,0)"
	clip: false
tab_container.content.draggable = false

# ********************************************************
# TAB 1
# ********************************************************

tab_1_container = new Layer
	width: Screen.width - gap
	height: Screen.height - tab_bar.height
	x: Align.center
	backgroundColor: "rgba(0,0,0,0)"
tab_container.addPage tab_1_container

# Create Scroll Box
forecast_scroll = new ScrollComponent
	width: 650
	height: 1005
	x: Align.center
	y: status_bar.height + gap + 10
	image: "images/container.png"
	scrollHorizontal: false
	borderRadius: 40
	parent: tab_1_container # Add as child of tab container
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
	parent: tab_1_container # Add as child of tab container

cancel = new Layer
	image: "images/cancel.png"
	width: 202
	height: 97
	x: 0
	y: Screen.height - tab_bar.height - 97 - (gap * 0.5)
	opacity: 0
	parent: tab_1_container # Add as child of tab container
arrive_tomorrow = new Layer
	image: "images/arriving_tomorrow.png"
	width: 423
	height: 97
	x: cancel.width + (gap * 0.5)
	y: Screen.height - tab_bar.height - 97 - (gap * 0.5)
	opacity: 0
	parent: tab_1_container # Add as child of tab container

# Add top and bottom inset
scroll.contentInset =
	top: 20
	bottom: 20

# Add items
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

# ********************************************************
# TAB 2
# ********************************************************

tab_2_container = new Layer
	width: Screen.width - gap
	height: Screen.height - tab_bar.height
	backgroundColor: "rgba(150,50,50,0.2)"
tab_container.addPage tab_2_container

# ********************************************************
# TAB 3
# ********************************************************

tab_3_container = new Layer
	width: Screen.width - gap
	height: Screen.height - tab_bar.height
	backgroundColor: "rgba(50,250,50,0.2)"
tab_container.addPage tab_3_container

# ********************************************************
# TAB 4
# ********************************************************

tab_4_container = new Layer
	width: Screen.width - gap
	height: Screen.height - tab_bar.height
	backgroundColor: "rgba(250,0,100,0.3)"
tab_container.addPage tab_4_container

# ********************************************************
# Tab bar touch events
# ********************************************************
tab_container.snapToPage(tab_1_container) # fixes weird glitch
tab_icon_1_handler = (event, layer) ->
    tab_icon_1.image = "images/tab_bar_components/tab_blue_1.png"
    tab_icon_2.image = "images/tab_bar_components/tab_grey_2.png"
    tab_icon_3.image = "images/tab_bar_components/tab_grey_3.png"
    tab_icon_4.image = "images/tab_bar_components/tab_grey_4.png"
    tab_container.snapToPage(tab_1_container)
tab_icon_1.on(Events.Click, tab_icon_1_handler)
tab_icon_2_handler = (event, layer) ->
    tab_icon_1.image = "images/tab_bar_components/tab_grey_1.png"
    tab_icon_2.image = "images/tab_bar_components/tab_blue_2.png"
    tab_icon_3.image = "images/tab_bar_components/tab_grey_3.png"
    tab_icon_4.image = "images/tab_bar_components/tab_grey_4.png"
    tab_container.snapToPage(tab_2_container)
tab_icon_2.on(Events.Click, tab_icon_2_handler)
tab_icon_3_handler = (event, layer) ->
    tab_icon_1.image = "images/tab_bar_components/tab_grey_1.png"
    tab_icon_2.image = "images/tab_bar_components/tab_grey_2.png"
    tab_icon_3.image = "images/tab_bar_components/tab_blue_3.png"
    tab_icon_4.image = "images/tab_bar_components/tab_grey_4.png"
    tab_container.snapToPage(tab_3_container)
tab_icon_3.on(Events.Click, tab_icon_3_handler)
tab_icon_4_handler = (event, layer) ->
    tab_icon_1.image = "images/tab_bar_components/tab_grey_1.png"
    tab_icon_2.image = "images/tab_bar_components/tab_grey_2.png"
    tab_icon_3.image = "images/tab_bar_components/tab_grey_3.png"
    tab_icon_4.image = "images/tab_bar_components/tab_blue_4.png"
    tab_container.snapToPage(tab_4_container)
tab_icon_4.on(Events.Click, tab_icon_4_handler)