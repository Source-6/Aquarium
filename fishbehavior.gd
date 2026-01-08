class_name Fish
extends RigidBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var fishVisual: AnimatedSprite2D = $FishVisual
@onready var medium_fish: Fish = $"."
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D




var impulse : int
var startPos = Vector2(250,100)
var randFlipped 
@export var prefered_velocity : Vector2
@export var maxVel : int
@export var alreadyPressed = false

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

func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("moveSomething") && not alreadyPressed:  #if we clicked
		linear_velocity += Vector2(impulse*5,0)
		cpu_particles_2d.emitting = true
		alreadyPressed = true
	elif Input.is_action_just_released("moveSomething") && alreadyPressed:
		alreadyPressed = false 




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	linear_velocity *= -1
	impulse *= -1 
	fishVisual.flip_h = !fishVisual.flip_h
	prefered_velocity *= -1
