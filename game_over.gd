extends CanvasLayer

@onready var main = get_parent()

func _ready():
	visible = false  # Hide by default

func show_game_over():
	visible = true

func hide_game_over():
	visible = false

# Removed any _input handling here. All input for restart is handled in main.gd.
