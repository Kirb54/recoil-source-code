extends CanvasLayer

@onready var boxamount = bt.getboxcount()
@onready var label = $boxlabel
var boxesbroken = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(boxesbroken) + '/' + str(boxamount) + ' Boxes Broken'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boxesbroken != bt.boxbroken:
		boxesbroken = bt.boxbroken
		label.text = str(boxesbroken) + '/' + str(boxamount) + ' Boxes Broken'
		if boxesbroken == boxamount:
			bt.canleave = true
