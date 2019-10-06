extends Area2D

export (int) var speed = 150

func _on_Visibility_screen_exited():
    queue_free()

func _process(delta):
    var velocity = Vector2(speed ,0).rotated(rotation)
    position += velocity * delta