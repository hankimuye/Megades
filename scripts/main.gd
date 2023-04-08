extends Node2D


@onready var player = $"/root/World/Player"
@onready var health_label = $"/root/World/HUD/UI/Health"
@onready var ammo_label = $"/root/World/HUD/UI/Ammo"
@onready var score_label = $"/root/World/HUD/UI/Score"
@onready var game_over_label = $"/root/World/HUD/UI/GameOver"
@onready var screen_cover = $"/root/World/HUD/UI/ScreenCover"

var bluebird = preload("res://scenes/enemy.tscn")
var redbird = preload("res://scenes/redbird.tscn")
var greybird = preload("res://scenes/greybird.tscn")
var greenbird = preload("res://scenes/greenbird.tscn")
var purplebird = preload("res://scenes/purplebird.tscn")
var yellowbird = preload("res://scenes/yellowbird.tscn")

var rng = RandomNumberGenerator.new()
var game_ended = false
var music_pitch: float = 0.8


func _ready():
	rng.randomize()
	player.player_died.connect(_on_player_died)


func _process(_delta):
	if game_ended == true:
		if Input.is_action_just_pressed("shoot"):
			get_tree().reload_current_scene()

	#take care of ammo and health indicators
	health_label.text = "Health: %s" % player.health
	ammo_label.text = "Ammo: %s" % player.ammo
	score_label.text = "Score: %s" % player.score
		
func _on_player_died():
	game_over_label.text = game_over_label.text % player.score
	game_over_label.set_visible(true)
	screen_cover.set_visible(true)
	player.health = 0
	game_ended = true
	$PigeonSpawner.stop()
	$BackgroundMusic.stop()


func _spawn_pigeons():
		var available_birds = [
			bluebird,
			redbird,
			greybird,
			greenbird,
			purplebird,
			yellowbird
		]
		var bird_index = rng.randi_range(0, available_birds.size() -1)
		var new_pigeon = available_birds[bird_index].instantiate()
		var y = rng.randi_range(40,560)
		new_pigeon.position = Vector2(750, y)
		add_child(new_pigeon)


func _on_pigeon_spawner_timeout():
	_spawn_pigeons()
	$PigeonSpawner.start()


func _on_level_up_timer_timeout():
	$PigeonSpawner.wait_time -= 0.1
	if $PigeonSpawner.wait_time == 0.1:
		$PigeonSpwaner.wait_time = 0.2
	music_pitch += 0.1
	$BackgroundMusic.set_pitch_scale(music_pitch)
	$LevelUpTimer.start()
