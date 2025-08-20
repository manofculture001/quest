extends Area2D

var velocity = Vector2()
@export var jump_strength = -250.0
@onready var main = get_parent()
var dead = false

func _ready():
	set_process(false)

func reset_player():
	position = Vector2(80, 8)
	velocity = Vector2()
	dead = false
	set_process(true)

func _process(delta):
	if main.playing and not dead:
		velocity.y += gravity * delta
		position.y += velocity.y * delta
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_strength
		if position.y < 0 or position.y > get_viewport_rect().size.y:
			dead = true
			main.on_player_death()
			set_process(false)

func _on_area_entered(area):
	if not dead:
		dead = true
		main.on_player_death()
		set_process(false)
