extends Node2D

var score = 0
	
	
func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.killed.connect(_on_mob_killed)
	
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_mob_killed():
	score+=10
	%ScoreLabel.text = "Score:" + str(score)
