extends Area2D

signal obstacle_passed

@export var speed: int = 200
var word: String = ""

func set_word(value):
	word = value
	if has_node("Label"):
		$Label.text = word

func _ready():
	$Label.text = word

func _physics_process(delta):
	position.x -= speed * delta
	if position.x < -200:
		emit_signal("obstacle_passed")
		queue_free()
