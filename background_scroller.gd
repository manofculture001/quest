extends Node2D

@export var scroll_speed: float = 100.0

@onready var bg1 := $BG1
@onready var bg2 := $BG2

var bg_width: float

func _ready():
	bg_width = bg1.texture.get_width()
	# Ensure BG2 is placed right after BG1
	bg2.position.x = bg1.position.x + bg_width

func _process(delta):
	# Move both backgrounds left
	bg1.position.x -= scroll_speed * delta
	bg2.position.x -= scroll_speed * delta

	# If a background has moved completely offscreen, move it to the right
	if bg1.position.x <= -bg_width:
		bg1.position.x = bg2.position.x + bg_width
	if bg2.position.x <= -bg_width:
		bg2.position.x = bg1.position.x + bg_width
