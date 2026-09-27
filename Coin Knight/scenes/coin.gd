extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		# Tell the HUD to add a coin
		var hud = get_tree().get_first_node_in_group("hud")
		if hud:
			hud.add_coin()
		
		# Disable collision immediately so it can't be triggered twice during the animation
		if has_node("CollisionShape2D"):
			$CollisionShape2D.set_deferred("disabled", true)
			
		# Play your pickup animation (sound + queue_free built into track)
		animation_player.play("collect")
