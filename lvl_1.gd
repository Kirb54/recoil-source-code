extends Node2D

@onready var warning = $warninglabel
# Called when the node enters the scene tree for the first time.
func _ready():
	warning.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_oob_body_entered(body):
	if body.is_in_group('player'):
		warning.global_position.x = body.global_position.x
		warning.show()


func _on_deathhole_body_entered(body):
	if body.is_in_group('player'):
		body.die()
