extends HBoxContainer

var full_heart_res = preload("res://Assets/Visuals/HeartFull.png")
var empty_heart_res = preload("res://Assets/Visuals/HeartEmpty.png")

func _on_protagonist_health_changed(health):
	
	match health:
		0:
			$TextureRect.texture = empty_heart_res
			$TextureRect2.texture = empty_heart_res
			$TextureRect3.texture = empty_heart_res
		1:
			$TextureRect.texture = full_heart_res
			$TextureRect2.texture = empty_heart_res
			$TextureRect3.texture = empty_heart_res
		2:
			$TextureRect.texture = full_heart_res
			$TextureRect2.texture = full_heart_res
			$TextureRect3.texture = empty_heart_res
		3:
			$TextureRect.texture = full_heart_res
			$TextureRect2.texture = full_heart_res
			$TextureRect3.texture = full_heart_res
