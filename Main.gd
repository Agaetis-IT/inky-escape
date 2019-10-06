extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var pulse_speed = 1.0
onready var light = get_node("Light")
var can_press = false
var success = false
var qte = ["a","b","x","y"]
# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    $PulseTimer.wait_time = pulse_speed
    $PulseTimeTimer.wait_time = pulse_speed / 4
    var tween = get_node("Tween")
    tween.interpolate_property(light, "modulate:a",
            1 ,0.2, pulse_speed,
            Tween.TRANS_SINE, Tween.EASE_OUT)
    tween.start()
    $PulseTimer.start()
    

func _on_PulseTimer_timeout():
    can_press = true
    $PulseTimeTimer.start()

func _on_PulseTimeTimer_timeout():
    can_press = false
    print(success)
    if is_instance_valid($QTE) and success == false and $QTE.qte_progress != 0:
        $QTE.reset_qte()
    success = false

func _process(delta):
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
    $QTE.queue_free()