extends CharacterBody2D

@export var firedeathsfx : AudioStream
@export var fireupsfx : AudioStream
const speed = 300
var direction : int
@onready var anim = $AnimatedSprite2D
var blownup = false
@onready var area = $Area2D/CollisionShape2D
@onready var blowuptimer = $blowuptimer
var goingup = false
var goingdown = false
func _ready():
	anim.play('fire')
	if direction == -1:
		area.position.x = -34
		anim.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not blownup:
		if goingup:
			velocity.x = 0
			velocity.y = -speed
		elif goingdown:
			velocity.x = 0
			velocity.y = speed
		else:
			velocity.x = speed * direction
	
	
	move_and_slide()


func getdirection(d):
	direction = d

	


func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		body.die()
	if body.is_in_group('tiles'):
		blowup()
	if body.is_in_group('box'):
		body.destroy()
		blowup()




func blowup():
	blownup = true
	sfx.playsound(firedeathsfx)
	velocity.x = 0
	velocity.y = 0
	anim.play("blownup")
	area.disabled = true
	blowuptimer.start()
	await blowuptimer.timeout
	self.queue_free()


func up(pos):
	if direction == 1:
		rotation_degrees = -90
	else:
		rotation_degrees = 90
	goingup = true
	goingdown = false
	sfx.playsound(fireupsfx)
	global_position.x = pos


func down(pos):
	if direction == 1:
		rotation_degrees = 90
	else:
		rotation_degrees = -90
	goingdown = true
	goingup = false
	sfx.playsound(fireupsfx)
	global_position.x = pos

func left(pos):
	goingup = false
	goingdown = false
	rotation_degrees = 0
	sfx.playsound(fireupsfx)
	direction = -1
	velocity.y = 0
	global_position.y = pos
	anim.flip_h = true
	area.position.x = -34

func right(pos):
	goingup = false
	goingdown = false
	rotation_degrees = 0
	velocity.y = 0
	sfx.playsound(fireupsfx)
	direction = 1
	global_position.y = pos
	anim.flip_h = false
	area.position.x = 6
