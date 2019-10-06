extends KinematicBody2D

export (int) var max_speed = 700
export (int) var acceleration = 150
export (int) var decelerate = 250

var velocity = Vector2()
var lastVelocity = Vector2()
var speed = 0

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right') || Input.is_action_pressed('right') :
        velocity.x += 1
    if Input.is_action_pressed('ui_left') || Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down') || Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up') || Input.is_action_pressed('up'):
        velocity.y -= 1
    
    # if player move
    if velocity != Vector2.ZERO:
        lastVelocity = velocity
        speed += acceleration
        if speed > max_speed:
            speed = max_speed
    # if player stop movement
    else:
        velocity = lastVelocity
        speed -= decelerate
        if speed < 0:
            speed = 0
        
    velocity = velocity.normalized() * speed
    
func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)