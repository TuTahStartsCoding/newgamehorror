# Scripts/CoinPickup.gd
# แก้ไข: ค้นหา Player โดยตรงแทนการใช้ body parameter
extends Sprite2D

@export var value = 5
@export var heal_amount : int = 10  # ปรับได้ใน Inspector

var time_passed = 0
var initial_position := Vector2.ZERO
@export var amplitude := 3.0
@export var frequency := 4.0

func _ready():
	initial_position = position

func _process(_delta):
	body_hover(_delta)

func body_hover(delta):
	time_passed += delta
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		# เพิ่มเงิน
		GameManager.add_money(value)
		
		# Heal โดยค้นหา Player จาก group
		var player = get_tree().get_first_node_in_group("Player")
		if player and player.has_method("_heal"):
			player._heal(heal_amount)
		
		AudioManager.play_sound(AudioManager.COIN_PICK, 0, -10)
		queue_free()
