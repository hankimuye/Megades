extends Node2D


@onready var player = $"/root/World/Player"
@onready var health_label = $"/root/World/HUD/UI/Health"
@onready var ammo_label = $"/root/World/HUD/UI/Ammo"
@onready var score_label = $"/root/World/HUD/UI/Score"
@onready var game_over_label = $"/root/World/HUD/UI/GameOver"
@onready var screen_cover = $"/root/World/HUD/UI/ScreenCover"

var thebirds = preload("res://scenes/the_birds.tscn")

var bird_index = [
	["bluebird", -60, 1.0,], 
	["greybird", -65, 0.9,], 
	["redbird", -70, 1.1,], 
	["greenbird", -75, 1.2,], 
	["yellowbird", -80, 1.3,], 
	["purplebird", -90, 1.4,]
	]
#var number_of_birds = [0, 4, 8 , 12, 16, 20]
var firstbird = 6
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

	var picked_bird = rng.randi_range(0, bird_index.size() - firstbird)

	var spawn_bird = thebirds.instantiate()
	var y = rng.randi_range(40,560)
	spawn_bird.position = Vector2(750, y)
	spawn_bird.playthis = bird_index[picked_bird][0]
	spawn_bird.speed = bird_index[picked_bird][1]
	spawn_bird.die_pitch = bird_index[picked_bird][2]
	add_child(spawn_bird)


func _on_pigeon_spawner_timeout():
	_spawn_pigeons()
	$PigeonSpawner.start()


func _on_level_up_timer_timeout():
	firstbird -= 1
	if firstbird < 1: firstbird = 1
	$PigeonSpawner.wait_time -= 0.1
	if $PigeonSpawner.wait_time == 0.1:
		$PigeonSpwaner.wait_time = 0.2
	music_pitch += 0.1
	$BackgroundMusic.set_pitch_scale(music_pitch)
	$LevelUpTimer.start()
