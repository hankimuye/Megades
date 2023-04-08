extends RigidBody2D

@export var speed = 280

var velocity = Vector2.ZERO

@onready var player = $"/root/World/Player"

var time2live = 0

func _ready():
	time2live = Time.get_ticks_msec() + 3000
	
func _process(_delta):
	if Time.get_ticks_msec() >= time2live:
		queue_free()
		
		
func _physics_process(delta):
	var distance = Vector2.RIGHT * speed * delta
	var collision = move_and_collide(distance)
	if collision:
		queue_free()
		if collision.get_collider().is_in_group("pigeon"):
			collision.get_collider().die()
			player.score += 1


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
