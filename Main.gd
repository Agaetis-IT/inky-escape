extends Node

export (PackedScene) var Bullet

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var pulse_speed = 1.0
onready var light = get_node("Light")
var can_press = false
var success = false
var level_finished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$PulseTimer.wait_time = pulse_speed
	$PulseTimeTimer.wait_time = pulse_speed / 4
	var tween = get_node("Tween")
	tween.interpolate_property(light, "modulate:a",
			1 ,0.2, pulse_speed,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	$PulseTimer.start()
	

func _on_PulseTimer_timeout():
	can_press = true
	$PulseTimeTimer.start()
	
	for i in range(2):
		# Choose a random location on Path2D.
		$BulletPath/BulletSpawnLocation.set_offset(randi())
		# Create a Bullet instance and add it to the scene.
		var bullet = Bullet.instance()
		add_child(bullet)
		# Set the bullet's direction perpendicular to the path direction.
		var direction = $BulletPath/BulletSpawnLocation.rotation + PI / 2
		# Set the bullet's position to a random location.
		bullet.position = $BulletPath/BulletSpawnLocation.position
		bullet.connect("body_entered", self, "_on_Bullet_body_entered")
		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		bullet.rotation = direction

func _on_Bullet_body_entered(body):
	print(body.name)
	if body.name == "Player":
		var new_door_progress = $Door.door_progress - 1
		if $Door.door_progress != 0:
			$Door.change_door_progress(new_door_progress)

func _on_PulseTimeTimer_timeout():
	can_press = false
	if is_instance_valid($QTE) and success == false and $QTE.qte_progress != 0:
		$QTE.reset_qte()
	success = false

func _physics_process(delta):
	if can_press:
		if is_instance_valid($QTE):
			if $QTE.qte[$QTE.qte_progress] == "a" and Input.is_action_just_pressed("ui_a"):
				qte_success()
			elif $QTE.qte[$QTE.qte_progress] == "b" and Input.is_action_just_pressed("ui_b"):
				qte_success()
			elif $QTE.qte[$QTE.qte_progress] == "x" and Input.is_action_just_pressed("ui_x"):
				qte_success()
			elif $QTE.qte[$QTE.qte_progress] == "y" and Input.is_action_just_pressed("ui_y"):
				qte_success()
			elif $QTE.qte_progress != 0 and (Input.is_action_just_pressed("ui_a") or Input.is_action_just_pressed("ui_b") or Input.is_action_just_pressed("ui_x") or Input.is_action_just_pressed("ui_y")):
				$QTE.reset_qte()
			
func qte_success():
	success = true
	$QTE.qte_progress += 1
	if $QTE.qte_progress == 4:
		level_end()
		
func level_end():
	var new_door_progress = $Door.door_progress + 1
	$Door.change_door_progress(new_door_progress)
	if new_door_progress < $Door.door_numbers:
		$QTE.reset_qte()
	else:
		$QTE.queue_free()
		level_finished = true

func _on_Door_body_entered(body):
	if body.name == "Player" and level_finished:
		get_tree().quit()
