extends Node2D

var guys = [
	["john", "smith", 15, 2], 
	["larry", "johnson", 32, 4], 
	["tom", "peterson", 28, 500], 
	["pete", "jackson", 17, 6.7]
	]
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	

func print_random_names():
	var ap = rng.randi_range(0, guys.size()-1)
	print(guys.size())
	print(ap)
	print(guys[ap][0])
	#var firstname = guys[ap][0]
	#var lastname = guys[ap][1]
	#var age = guys[ap][2]
#	var id = guys[ap][3]
#	print(firstname)
#	print(lastname)
#	print(age)
#	print(id)


func _on_timer_timeout():
	print_random_names()
	$Timer.start()
