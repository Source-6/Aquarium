extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("moveSomething"):  #if we clicked
		animated_sprite_2d.play()
		timer.start(1)
		cpu_particles_2d.emitting = true


func _on_timer_timeout() -> void:
	animated_sprite_2d.stop()
