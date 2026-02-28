extends Node

@export var back_scene : PackedScene
@export var door_blocker : StaticBody2D
@export var enemies_node : Node
@onready var warning_label = $WarningLabel

var is_locked = true

func _ready():
	set_door_locked(true)
	warning_label.text = "ทางผิด!\nกำจัดศัตรูให้หมดก่อน!"

func _process(_delta):
	if is_locked:
		if enemies_node.get_child_count() == 0:
			unlock_door()

func set_door_locked(locked: bool):
	is_locked = locked
	if door_blocker:
		door_blocker.visible = locked
		var col = door_blocker.get_node_or_null("CollisionShape2D")
		if col:
			col.disabled = !locked

func unlock_door():
	set_door_locked(false)
	warning_label.text = "ประตูเปิดแล้ว กลับไปเลือกประตูใหม่"
	await get_tree().create_timer(2.0).timeout
	if back_scene:
		GameManager.load_next_level(back_scene)
