extends RigidBody2D

var has_hit_ground = false

var num_bounces = 2
var max_bounces = 2

var sound_max_velocity = 100


func _ready():
	get_tree().create_timer(10.0).connect("timeout", Callable(self, "_on_despawn_timer_timeout"))


func _on_body_entered(body):
	
	if body.is_in_group("Protagonist"):
		if !has_hit_ground:
			body.take_damage()
			has_hit_ground = true
		
		impact()
	
	elif body.is_in_group("Ground"):
		
		impact()


func impact():
	
	if num_bounces == max_bounces:
		$AudioStreamPlayer2D.play()
	
	num_bounces -= 1
	
	if num_bounces <= 0:
		has_hit_ground = true


func _on_despawn_timer_timeout():
	self.queue_free()
