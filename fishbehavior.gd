class_name Fish
extends RigidBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var fishVisual: AnimatedSprite2D = $FishVisual
@onready var medium_fish: Fish = $"."
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var audioBubbles: AudioStreamPlayer2D = $AudioStreamPlayer2D




var impulse : int
var startPos = Vector2(250,100)
var randFlipped 
@export var prefered_velocity : Vector2
@export var maxVel : int
@export var alreadyPressed = false
@export var speed : int
var destination : Vector2
var chasing = false

func _ready() -> void:
	randFlipped = randi()%2
	
	if randFlipped == 1:
		fishVisual.flip_h = false
		impulse = -20
		prefered_velocity.x = -prefered_velocity.x
	else :
		fishVisual.flip_h = true
		impulse = 20

	linear_velocity = Vector2(prefered_velocity.x,0)  #starting speed



func _process( _delta: float) -> void:
	#print(linear_velocity)
	if linear_velocity.length() > maxVel:
		linear_velocity = lerp(linear_velocity, prefered_velocity,1-pow(.05,_delta))
	if Input.is_action_pressed("feed"):
		chaseFood(_delta)



func chaseFood(_delta: float) ->void:
	chasing = true
	destination = collision_shape_2d.get_global_mouse_position() #add an offset like a circle 
	if position != destination && chasing:
		linear_velocity = Vector2(destination-position * speed)
	if position == destination && Input.is_action_just_released("feed"):
		chasing = false 
		linear_velocity = prefered_velocity

	print("destination : ",destination, ", position : ", position)

func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("moveSomething") && not alreadyPressed:  #if we clicked
		linear_velocity += Vector2(impulse*5,0)
		cpu_particles_2d.emitting = true
		alreadyPressed = true
		audioBubbles.play()
	elif Input.is_action_just_released("moveSomething") && alreadyPressed:
		alreadyPressed = false 




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	linear_velocity *= -1
	impulse *= -1 
	fishVisual.flip_h = !fishVisual.flip_h
	prefered_velocity *= -1
