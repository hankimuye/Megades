extends CharacterBody2D

@onready var player = $"/root/World/Player"
@export var speed = -60
@export var die_pitch = 1.0

var flying = true

func _ready():
	player.player_died.connect(_on_player_died)

func _process(_delta):
	pass

func _physics_process(_delta):
	if flying == true:
		velocity.x = speed #* delta
		$AnimatedSprite2D.play("fly")
	move_and_slide()


func _on_player_died():
	flying = false


func die():
	flying = false
	$EnemyHitBox/CollisionShape2D.set_deferred("disabled", true)
	$Kakaoo.play()
	$AnimatedSprite2D.play("fall")
	velocity.x = 0
	velocity.y = 300



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	player.health -= 5 
