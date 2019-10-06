extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var number_of_button = 4
var screen_size
var qte_progress = 0
var qte = Array() 
var sprites = Array() 
# Called when the node enters the scene tree for the first time.
func _ready():
	sprites.resize(number_of_button)
	qte.resize(number_of_button)
	screen_size = get_viewport_rect().size
	for i in range(number_of_button):
		var rand = randi()%4
		match rand:
			0: qte[i] = "a"
			1: qte[i] = "b"
			2: qte[i] = "x"
			3: qte[i] = "y"

		var sprite = Sprite.new()
		sprite.texture = load("res://assets/sprites/buttons/"+qte[i]+".png")
		sprite.position = Vector2(screen_size.x*i/number_of_button,0)
		sprites[i] = sprite
		add_child(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(number_of_button):
		if i == qte_progress:
			sprites[i].modulate.a = 1
		else:
			sprites[i].modulate.a = 0.5

func reset_qte():
	qte_progress = 0
	for i in range(number_of_button):
		var rand = randi()%4
		match rand:
			0: qte[i] = "a"
			1: qte[i] = "b"
			2: qte[i] = "x"
			3: qte[i] = "y"
		sprites[i].texture = load("res://assets/sprites/buttons/"+qte[i]+".png")