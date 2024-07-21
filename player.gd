extends CharacterBody2D

@export var shootsfx : AudioStream
@export var tpsfx : AudioStream
@export var deathsfx : AudioStream

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimatedSprite2D
@onready var tptimer = $tptimer
var bored = true
@onready var fireball = preload("res://fireball.tscn")
@onready var shoottimer = $shoottimer
var recoilstr = 800
var weakcoil = 200
var shakestr = 10
@onready var recoiltimer = $recoiltimer
@onready var deathtimer = $deathtimer
@onready var tpiframes = $tpiframes
@onready var tppart = $tpparticles
@onready var shootpart = $shootpart
@onready var slidepart = $slidepart
@onready var cam = $Camera2D



func _physics_process(delta):
	animations()
	tp()
	shoot()
	walk()
	grav(delta)
	move_and_slide()
	deathshake()
	reset()
	leave()

func walk():
	if bored:
		if Input.is_action_pressed("ui_left"):
			direction = -1
		elif Input.is_action_pressed("ui_right"):
			direction = 1
		
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, 80)
	else:
		velocity.x = move_toward(velocity.x, 0, 30)


func grav(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		

func tp():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and bored:
		bored = false
		anim.play('teleport')
		tptimer.start()
		var tpos = get_global_mouse_position()
		await tptimer.timeout
		sfx.playsound(tpsfx)
		if not zones.redzone:
			tppart.emitting = true
			tpiframes.start()
			
			var ogpos = global_position
			global_position = tpos
			var ball = get_tree().get_first_node_in_group('fireball')
			if ball != null:
				ball.global_position = ogpos
			bored = true
		else:
			await anim.animation_finished
			bored = true


func animations():
	if bored:
		if velocity.x != 0:
			anim.play('walk')
			anim.flip_h = getanimflip()
		else:
			anim.play("idle")
			anim.flip_h = getanimflip()
			

func getanimflip():
	if direction == 1:
		return false
	else:
		return true



func shoot():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and bored:
		bored = false
		velocity.x = 0
		anim.play('shoot')
		shoottimer.start()
		await shoottimer.timeout
		
		
		var inst = fireball.instantiate()
		var ballpos
		if direction == 1:
			ballpos = global_position + Vector2(60,0)
			shootpart.position = Vector2(63,5)
		else:
			ballpos = global_position - Vector2(60,0)
			shootpart.position = Vector2(-63,5)
		
		inst.global_position = ballpos
		inst.getdirection(direction)
		sfx.playsound(shootsfx)
		if not zones.bluezone:
			add_sibling(inst)
			velocity.x = recoilstr * -direction
			shootpart.direction.x = direction
			shootpart.emitting = true
		else:
			velocity.x = weakcoil * -direction
		recoiltimer.start()
		slidepart.direction.x = direction
		slidepart.emitting = true
		await recoiltimer.timeout
		
		
		bored = true

func die():
	if tpiframes.time_left == 0 and deathtimer.time_left == 0:
		bored = false
		anim.play('death')
		deathtimer.start()
		sfx.playsound(deathsfx)
		await deathtimer.timeout
		bt.reset()
		get_tree().reload_current_scene()

func deathshake():
	if deathtimer.time_left != 0:
		anim.animation = 'death'
		var xoffset = randf_range(-shakestr,shakestr)
		var yoffset = randf_range(-shakestr,shakestr)
		cam.offset = Vector2(xoffset,yoffset - 30)
		shakestr /= 1.2
		

func done():
	bored = false

func reset():
	if Input.is_action_pressed("reset") and deathtimer.time_left == 0:
		bt.reset()
		get_tree().reload_current_scene()

func leave():
	if Input.is_action_pressed('ui_cancel') and deathtimer.time_left == 0:
		bt.reset()
		get_tree().change_scene_to_file("res://lvl_select.tscn")
