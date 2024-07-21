extends Area2D

@onready var clear = $cleartext
@onready var timer = $cleartimer
@onready var particles = $CPUParticles2D
func _ready():
	clear.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group('player') and bt.canleave:
		body.hide()
		body.done()
		timer.start()
		particles.emitting = true
		await timer.timeout
		bt.reset()
		get_tree().change_scene_to_file("res://lvl_select.tscn")
