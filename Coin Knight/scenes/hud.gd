extends CanvasLayer

@onready var coins_label: Label = $CoinsLabel
@onready var popup_label: Label = $PopupLabel
@onready var win_label: Label = $WinLabel
@onready var death_label: Label = $DeathLabel

var total_coins: int = 0
var coins_collected: int = 0

func _ready():
	win_label.visible = false
	popup_label.visible = false
	death_label.visible = false
	
	var coins_container = get_parent().get_node_or_null("Coins")
	if coins_container:
		total_coins = coins_container.get_child_count()
	
	update_ui()

func show_death_message():
	death_label.visible = true

func add_coin():
	coins_collected += 1
	update_ui()
	show_popup()
	
	# Win Condition
	if coins_collected >= total_coins and total_coins > 0:
		win_label.text = "All coins collected!"
		win_label.visible = true
		
		# Wait 2 seconds so the player can read the message, then restart
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()

func update_ui():
	coins_label.text = "Coins: " + str(coins_collected) + " / " + str(total_coins)

func show_popup():
	popup_label.visible = true
	await get_tree().create_timer(1.0).timeout
	popup_label.visible = false
