extends Area2D 

@export var speed: float = 200.0
var direction: float = -1.0

func _physics_process(delta):
	position.x += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player") or body.name == "Player":
		# Slow down the game time speed
		Engine.time_scale = 0.5
		
		# Remove player collision shape so they fall through the floor
		if body.has_node("CollisionShape2D"):
			body.get_node("CollisionShape2D").queue_free()
		
		# Hide the pellet on impact and stop its movement
		visible = false
		set_physics_process(false)
		
		# Wait 0.5 seconds real-time, restore speed, and restart level
		await get_tree().create_timer(0.5).timeout
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
	else:
		# Destroy pellet if it hits a wall or tilemap block
		queue_free()
