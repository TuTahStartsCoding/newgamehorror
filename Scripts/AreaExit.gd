# Scripts/AreaExit.gd
# แก้ไขจากเดิม: เพิ่ม is_main_floor_exit เพื่อบอกว่าออกจาก MainFloor
extends Area2D

@onready var label = $Label
@export var next_scene : PackedScene

## ติ๊กถูกเฉพาะ AreaExit ที่อยู่ใน MainFloor เท่านั้น
@export var is_main_floor_exit : bool = false

func _ready():
	label.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("Enter") and label.visible == true:
		if is_main_floor_exit:
			GameManager.set_from_main(true)   # ด่านถัดไป heal เต็ม
		GameManager.load_next_level(next_scene)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
