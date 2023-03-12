extends CharacterBody2D

const MAX_SPEED = 200.0
const GRAVITY = 998
const JUMP_HEIGHT = -300

var health: int = 3
var score: int = 0

var is_on_ground = true
var jumps_remaining = 2

signal health_changed
signal score_changed
signal game_over


func _ready():
	emit_signal("health_changed", health)


func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	velocity.x = direction * MAX_SPEED
	
	if Input.is_action_pressed("MoveLeft"):
		$Sprite.flip_h = true
	if Input.is_action_pressed("MoveRight"):
		$Sprite.flip_h = false
	
	if Input.is_action_just_pressed("Jump") && jumps_remaining > 0:
		velocity.y += JUMP_HEIGHT
		is_on_ground = false
		jumps_remaining -= 1
	
	move_and_slide()


func take_damage():
	
	health -= 1
	
	emit_signal("health_changed", health)
	
	if health <= 0:
		emit_signal("game_over", score)
		print("game over")
		pass
		# game over, restart


func _on_area_2d_body_entered(body):
	
	if body.is_in_group("Ground"):
		is_on_ground = true
		jumps_remaining = 2


func _on_score_tick_timeout():
	
	if is_equal_approx(velocity.length(), 0.0):
		score += 1
		emit_signal("score_changed", score)
