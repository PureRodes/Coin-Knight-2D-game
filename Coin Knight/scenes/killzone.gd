extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		print("you got rekt bozo")
		Engine.time_scale = 0.5
		
		# Trigger the HUD "You Died!" message
		var hud = get_tree().get_first_node_in_group("hud")
		if hud and hud.has_method("show_death_message"):
			hud.show_death_message()
		
		# Safely remove the collision shape so the player falls
		if body.has_node("CollisionShape2D"):
			body.get_node("CollisionShape2D").queue_free()
			
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
