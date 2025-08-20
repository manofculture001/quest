extends Node2D

@onready var spawn_timer = $Timer
@onready var player = $player
@onready var score_label = $ScoreLabel
@onready var music = $Music
@onready var game_over = $GameOver

var obstacle_scene = preload("res://WordObstacle.tscn")
var words = ["chudel", "petty", "witch", "dumb", "idiot", "5ft4inch", "childish", "granny", "peasant", "lunatic", "Crazy"]
var score = 0
var playing = false

func _ready():
	randomize()
	spawn_timer.wait_time = 2.0
	spawn_timer.start()
	update_score_label()
	# (OPTIONAL) Force "emulate mouse from touch" at runtime for extra safety
	Input.set_emulate_mouse_from_touch(true)

func _on_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	var random_word = words[randi() % words.size()]
	obstacle.word = random_word
	obstacle.position = Vector2(1200, randf_range(0, 600))
	add_child(obstacle)
	obstacle.connect("obstacle_passed", Callable(self, "add_score"))

func start_game():
	playing = true
	score = 0
	update_score_label()
	spawn_timer.start()
	music.play()
	game_over.visible = false
	player.set_process(true)
	player.reset_player()

func game_over_screen():
	playing = false
	spawn_timer.stop()
	music.stop()
	game_over.visible = true
	player.set_process(false)
	# Only remove obstacles, not the player!
	for o in get_children():
		if o.name == "WordObstacle":
			o.queue_free()
func _unhandled_input(event):
	if not playing and (
		(event is InputEventMouseButton and event.pressed) or
		(event is InputEventScreenTouch and event.pressed)
	):
		start_game()

func on_player_death():
	game_over_screen()

func add_score():
	if playing:
		score += 1
		update_score_label()

func update_score_label():
	score_label.text = "Score: %d" % score
