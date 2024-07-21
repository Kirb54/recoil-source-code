extends CharacterBody2D

var grav = 800
@onready var part = preload("res://breakpart.tscn")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += grav * delta
	move_and_slide()


func destroy():
	var inst = part.instantiate()
	inst.global_position = global_position
	add_sibling(inst)
	bt.boxbroken += 1
	self.queue_free()

