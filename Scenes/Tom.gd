extends Sprite2D

const MAX_SPEED = 1.0
var move_speed_adj = 0.0
var move_left = false

var base_throw_interval = 5
var throw_interval_adj = 1.0

enum ProgressionType{
	BASE,
	ADJ
}

var next_progression = ProgressionType.ADJ

var cymbal_res = preload("res://Scenes/ThrownObjects/cymbal.tscn")
var tom1_res = preload("res://Scenes/ThrownObjects/tom_1.tscn")
var tom2_res = preload("res://Scenes/ThrownObjects/tom_2.tscn")


func _ready():
	$ThrowTimer.start(5.0)


func _process(_delta):
	
	if move_left:
		self.global_position.x += MAX_SPEED + move_speed_adj
		self.flip_h = false
	else:
		self.global_position.x -= MAX_SPEED + move_speed_adj
		self.flip_h = true


func _on_throw_timer_timeout():
	
	var object: RigidBody2D = get_random_drumset_piece()
	get_parent().add_child(object)
	object.global_position = self.global_position
	
	var rand_torque = (randf() * 75) + 75
	object.add_constant_torque(rand_torque)
	
	var timer_rand = randf() * (base_throw_interval * throw_interval_adj)
	$ThrowTimer.start(timer_rand)


func get_random_drumset_piece() -> Node:
	var obj_rand = randf() * 3
	
	if obj_rand > 0 && obj_rand <= 1:
		var cymbal = cymbal_res.instantiate()
		return cymbal
		
	elif obj_rand > 1 && obj_rand <= 2:
		var tom1 = tom1_res.instantiate()
		return tom1
		
	elif obj_rand > 2 && obj_rand <= 3:
		var tom2 = tom2_res.instantiate()
		return tom2
	
	else:
		return cymbal_res.instantiate()


func _on_speed_up_timer_timeout():
	move_speed_adj += 0.1


func _on_throw_speed_timer_timeout():
	
	match next_progression:
		
		ProgressionType.BASE:
			base_throw_interval = clamp(base_throw_interval - 1, 0.0, 5.0)
			next_progression = ProgressionType.ADJ
			
		ProgressionType.ADJ:
			throw_interval_adj = clamp(throw_interval_adj - 0.1, 0.1, 1.0)
			next_progression = ProgressionType.BASE


func _on_turn_dectector_area_entered(area):
	if area.is_in_group("Left"):
		move_left = true
	if area.is_in_group("Right"):
		move_left = false
