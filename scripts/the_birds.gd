extends CharacterBody2D

@onready var player = $"/root/World/Player"
@onready var animation = get_node("rodevogel")

@export var speed = 60
@export var die_pitch = 1.0
@export var playthis = "bluebird"

var flying = true

func _ready():
	print(animation)
	player.player_died.connect(_on_player_died)
	#animation.set_visible(true)
	
func _process(_delta):
	pass

func _physics_process(_delta):
	if flying == true:
		velocity.x = speed
		animation.play("fly")
	move_and_slide()


func _on_player_died():
	flying = false


func die():
	flying = false
	$EnemyHitBox/CollisionShape2D.set_deferred("disabled", true)
	$Kakoo.set_pitch_scale(die_pitch)
	$Kakoo.play()
	animation.play("fall")
	velocity.x = 0
	velocity.y = 300



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	player.health -= 5 



func _on_enemy_hit_box_area_entered(area):
	if area.is_in_group("player"):
		die()
