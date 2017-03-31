############# START #############
######### Set Background #########
background = new BackgroundLayer
	image: "images/background.png"

######### Variables #########
gap = 50

#########  Forecast box variables #########
rows = 8
gutter = 30
rowWidth = 849
rowHeight = 240
item_list = ["images/items/item_1.png","images/items/item_2.png","images/items/item_3.png","images/items/item_4.png","images/items/item_5.png","images/items/item_6.png","images/items/item_7.png","images/items/item_8.png"]

######### Main Placeholders #########
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
	y: gap + 25
	width: 949
	height: 441
weather = new Layer
	image: "images/weather.png"
	x: reminders.width + (gap * 2)
	y: clock.height + (gap * 2)
	width: 949
	height: 800

messageBox = new Layer
	x: 1201
	y: 1752
	width: 645
	height: 428
	image: "images/message.png"
messageBox.visible = false

########## Reminders #########
reminders_scroll = new ScrollComponent
	scrollHorizontal: false
	y: 50
	x: 50
	width: 949
	height: 1153
reminders_scroll.contentInset = 
	bottom: gap
reminders_label = new Layer
	html: "Reminders"
	fontFamily: "HanziPen TC"
	color: '#0d293e'
	parent: reminders_scroll.content
	backgroundColor: "rgba(2,0,0,0)"
	width: reminders_scroll.width
	opacity: 0.75
	y: 60
textStyle = { "text-align":"center", "font-size":"53px"}
reminders_label.style = textStyle

addNew = new Layer
	image: "images/confirm.png"
	width: 900
	height: 91
	y: 1218
	x: 75

for index in [0...rows]
	item_swipe = new ScrollComponent
		width: reminders_scroll.width
		height: rowHeight
		x: 0
		y:150 + index * (rowHeight + gutter)
		parent: reminders_scroll.content
		scrollVertical: false
	item_swipe.contentInset =
		right: 100
	item_swipe.content.draggable.directionLock = true
	item_swipe.content.draggable.directionLockThreshold =
		x: 0
		y: 10
	buttonDelete = new Layer
		image: "images/trash.png"
		parent: item_swipe.content
		x: 1171
		y: 63
		width: 79
		height: 115
	buttonEdit = new Layer
		image: "images/edit.png"
		parent: item_swipe.content
		x: 988
		y: 47
		width: 138
		height: 146
	cell = new Layer
		image: item_list[index]
		width: rowWidth
		height: rowHeight
		x: gap
		y: 0
		parent: item_swipe.content
	buttonEdit.onClick (event, layer) ->
		updateBox.visible = true
		keyBoardLayer.visible = true
		animationUpdateBoxIn.start()
		animationKeyboardIn.start()

######## Shopping Forecast ########
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
	color: '#0d293e'
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

for index in [0...rows]
	item_swipe = new ScrollComponent
		width: forecast_box.width
		height: rowHeight
		x: 0
		y:150 + index * (rowHeight + gutter)
		parent: forecast_scroll.content
		scrollVertical: false
	item_swipe.contentInset =
		right: 100
	item_swipe.content.draggable.directionLock = true
	item_swipe.content.draggable.directionLockThreshold =
		x: 0
		y: 10
	buttonDelete = new Layer
		image: "images/trash.png"
		parent: item_swipe.content
		x: 1171
		y: 63
		width: 79
		height: 115
	buttonEdit = new Layer
		image: "images/edit.png"
		parent: item_swipe.content
		x: 988
		y: 47
		width: 138
		height: 146
	cell = new Layer
		image: item_list[index]
		width: rowWidth
		height: rowHeight
		x: gap
		y: 0
		parent: item_swipe.content

############ Confirming and Cancelling touch events ##########
confirm_handler = (event, layer) ->
    confirm.opacity = 0
    arrive_tomorrow.opacity = 1
    cancel.opacity = 1
    cancel.y = Screen.height - 91 - gap # Return to correct position
    cancel.on(Events.Click, cancel_handler)
    confirm.off(Events.Click, confirm_handler)
    messageBox.visible = true
    forecast_scroll.visible = false
    forecast_label.parent = forecast_box
cancel_handler = (event, layer) ->
    confirm.opacity = 1
    arrive_tomorrow.opacity = 0
    cancel.opacity = 0
    cancel.y = Screen.height # Move out of way to prevent blocking touches to confirm
    messageBox.visible = false
    forecast_scroll.visible = true
    cancel.off(Events.Click, cancel_handler)
    confirm.on(Events.Click, confirm_handler)
confirm.on(Events.Click, confirm_handler)

#########  Update feature #########
keyBoardLayer = new Layer
	x: 19
	y: 2732
	width: 2061
	height: 960
	image: "images/keyboard.png"
	backgroundColor: "grey"

updateBox = new Layer
	x: 431
	y: 695
	width: 1237
	height: 871
	image: "images/updateBox.png"

messageBoxCancel = new Layer
	x: 425
	y: 695
	height: 75
	width: 123
	opacity: 0

messageBoxDone = new Layer
	x: 1576
	y: 695
	height: 75
	width: 98
	opacity: 0

updateBox.visible = false
keyBoardLayer.visible = false

messageBoxCancel.onClick (event, layer) ->
	animationUpdateBoxOut.start()
	animationKeyboardOut.start()

messageBoxDone.onClick (event, layer) ->
	animationUpdateBoxOut.start()
	animationKeyboardOut.start()

animationUpdateBoxOut = new Animation({
    layer: updateBox,
    properties: {opacity: 0},
    curve: "ease-out"
    time: 0.3
})

animationUpdateBoxIn = new Animation({
    layer: updateBox,
    properties: {opacity: 1},
    curve: "ease-in"
    time: 0.3
})


animationKeyboardOut = new Animation({
    layer: keyBoardLayer,
    properties: {opacity: 0
    x: 19
    y: 2732},
    curve: "ease-out"
    time: 0.3
})

animationKeyboardIn = new Animation({
    layer: keyBoardLayer,
    properties: {
    x: -13,
    y: 1781,
    opacity: 1},
    curve: "ease-in"
    time: 0.15
})

######### Clock animations #########
clockSep = new Layer
	x: 1493
	y: 136
	height: 293
	width: 59
	image: "images/clockSep.png"

animationA = new Animation({
    layer: clockSep,
    properties: {opacity: 0},
    time: 1
})

animationB = new Animation({
    layer: clockSep,
    properties: {opacity: 1},
    time: 1
})

animationA.start()

animationA.on Events.AnimationEnd, ->
    animationB.start()

animationB.on Events.AnimationEnd, ->
    animationA.start()
    
############# END #############
