# Scripts/Managers/GameManager.gd
# แก้ไขจากเดิม: เพิ่มระบบ player_health และ from_main_floor
extends Node

var money = 0
var player_health : int = -1   # -1 = ยังไม่ได้เซ็ต (จะ full ตอนเริ่ม)
var from_main_floor : bool = true  # true = มาจาก MainFloor → heal เต็ม

func reset_money():
	money = 0

func add_money(addmoney : int):
	money += addmoney

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)

func load_same_level():
	get_tree().reload_current_scene()

# บันทึก HP ก่อนเปลี่ยนด่าน
func save_player_health(hp : int):
	player_health = hp

# เรียกตอนออกจาก MainFloor → ด่านถัดไปจะ heal เต็ม
func set_from_main(is_main : bool):
	from_main_floor = is_main
