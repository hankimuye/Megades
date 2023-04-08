extends CharacterBody2D

signal player_died

@onready var game = $"/root/World"
@onready var health_postion = $"/root/World/Health"
@onready var ammo_potion = $"/root/World/Ammo"
@onready var auw_snd = $Auw

@export var health = 100
@export var player_max_health = 100
@export var speed = 280
@export var ammo = 10
@export var player_max_ammo = 50

var bullet = preload("res://scenes/flock_off.tscn")
var score = 0

func _process(_delta):
	if health <= 0:
		queue_free()
		emit_signal("player_died")
	if health > player_max_health:
		health = player_max_health

	if ammo > player_max_ammo:
		ammo = player_max_ammo
	
func _physics_process(_delta):
	if Input.is_action_pressed("down"):
		velocity.y = speed
	elif Input.is_action_pressed("up"):
		velocity.y = -speed
	else:
		velocity.y = 0
		
	move_and_slide()
	

func _on_hurtbox_area_entered(hitbox):
	if hitbox.is_in_group("pigeon"):
		health -= hitbox.damage
		auw_snd.play()
		$AnimationPlayer.play("on_hit")

	if hitbox.is_in_group("health"):
		health += hitbox.gives_health

	if hitbox.is_in_group("ammo"):
		ammo += hitbox.gives_ammo

		
func _input(event):
	if event.is_action_pressed("shoot") and ammo > 0:
		var bullet_instantiate = bullet.instantiate()
		bullet_instantiate.position = position
		game.add_child(bullet_instantiate)
		ammo -= 1
