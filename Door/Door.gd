extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var door_progress = 0
var door_numbers = 3
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_door_progress(new_door_progress):
    door_progress = new_door_progress
    match door_progress:
        0: $AnimatedSprite.animation = "3_bars"
        1: $AnimatedSprite.animation = "2_bars"
        2: $AnimatedSprite.animation = "1_bar"
        3: $AnimatedSprite.animation = "open"