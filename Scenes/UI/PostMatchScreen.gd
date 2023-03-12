extends ColorRect


func _on_protagonist_game_over(final_score):
	get_tree().paused = true
	
	self.visible = true
	
	$ScoreLabel.text = "Score: " + str(final_score)


func _on_play_again_button_pressed():
	get_tree().paused = false
	self.visible = false
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
