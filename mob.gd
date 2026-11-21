extends CharacterBody2D

signal  killed

var health = 3
var knockback_timer =  0.0

@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	if knockback_timer > 0:
		knockback_timer -= delta
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 250.0
	move_and_slide()
	
func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		killed.emit()
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		

func knockback():
	var direction = player.global_position.direction_to(global_position)
	velocity = direction * 350
	knockback_timer = 0.3
