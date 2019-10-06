extends Position2D

export (PackedScene) var Bullet

func _on_SpawnTimer_timeout():
    # Create a Bullet instance and add it to the scene.
    var bullet = Bullet.instance()
    add_child(bullet)
    bullet.position = position
    bullet.rotation = rotation
    # Set the velocity (speed & direction).
    bullet.linear_velocity = Vector2(bullet.speed, 0)
    bullet.linear_velocity = bullet.linear_velocity.rotated(rotation)
