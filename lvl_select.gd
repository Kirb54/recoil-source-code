extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_one_pressed():
	get_tree().change_scene_to_file("res://lvl_1.tscn")


func _on_two_pressed():
	get_tree().change_scene_to_file("res://lvl_2.tscn")


func _on_three_pressed():
	get_tree().change_scene_to_file("res://lvl_3.tscn")


func _on_four_pressed():
	get_tree().change_scene_to_file("res://lvl_4.tscn")


func _on_five_pressed():
	get_tree().change_scene_to_file("res://lvl_5.tscn")


func _on_six_pressed():
	get_tree().change_scene_to_file("res://lvl_6.tscn")


func _on_seven_pressed():
	get_tree().change_scene_to_file("res://lvl_7.tscn")


func _on_eight_pressed():
	get_tree().change_scene_to_file("res://lvl_8.tscn")


func _on_nine_pressed():
	get_tree().change_scene_to_file("res://lvl_9.tscn")


func _on_ten_pressed():
	get_tree().change_scene_to_file("res://lvl_10.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://startgame.tscn")
