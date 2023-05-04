extends CharacterBody2D

var power = 10
var slowdown = 1.03
var max_speed = 400

var push = Vector2.ZERO

var current_lap = 1
@onready var last_lap = get_node("..").last_lap

var passed_checkpoint = false

@onready var checkpoint = get_node("../Checkpoint")
@onready var finish_line = get_node("../FinishLine")
@onready var stopwatch = get_node("Stopwatch")
@onready var lap_counter = get_node("LapCounter")

func _physics_process(delta):
	
	if Input.is_action_just_pressed("restart_run"):
		restart_run()
	if Input.is_action_just_pressed("main_menu"):
		get_tree().change_scene_to_file("res://title_screen.tscn")
	
	push = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	push = push.normalized()
	
	if push.x != 0:
		velocity.x = velocity.x + (push.x * power)
	else:
		velocity.x = velocity.x / slowdown
	
	if push.y != 0:
		velocity.y = velocity.y + (push.y * power)
	else:
		velocity.y = velocity.y / slowdown
	
	if velocity.x > max_speed:
		velocity.x = max_speed
	if velocity.x < -max_speed:
		velocity.x = -max_speed
	if velocity.y > max_speed:
		velocity.y = max_speed
	if velocity.y < -max_speed:
		velocity.y = -max_speed
	
	move_and_slide()
	
	if get_slide_collision_count() != 0:
		velocity = velocity / 2

func restart_run():
	position = finish_line.position
	velocity = Vector2.ZERO
	stopwatch.time = 0
	stopwatch.running = true
	current_lap = 1
	lap_counter.set_text("Lap: 1")

func _on_finish_line_body_entered(body):
	if body.velocity.x * finish_line.orientation.x < 0:
		return
	if body.velocity.y * finish_line.orientation.y < 0:
		return
	if not passed_checkpoint:
		return
	passed_checkpoint = false
	current_lap += 1
	lap_counter.set_text("Lap: " + str(current_lap))
	if current_lap > last_lap:
		stopwatch.running = false
		lap_counter.set_text("FINISH! Press R to try again!")


func _on_checkpoint_body_entered(body):
	if body.velocity.x * checkpoint.orientation.x < 0:
		return
	if body.velocity.y * checkpoint.orientation.y < 0:
		return
	passed_checkpoint = true
