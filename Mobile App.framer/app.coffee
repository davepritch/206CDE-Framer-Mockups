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
	y: Screen.height - tab_bar.height - 97 - (gap / 2)

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