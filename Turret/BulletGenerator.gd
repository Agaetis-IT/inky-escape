extends Position2D

export (PackedScene) var Bullet

func _on_SpawnTimer_timeout():
    # Create a Bullet instance and add it to the scene.
    var bullet = Bullet.instance()
    bullet.position = position
    bullet.rotation = rotation
    add_child(bullet)