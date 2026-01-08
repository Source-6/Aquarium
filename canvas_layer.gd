extends CanvasLayer
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area_2d: Area2D = $Area2D
@onready var cpu_particles_2d: CPUParticles2D = $Area2D/CPUParticles2D


var mousePos


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cpu_particles_2d.position = collision_shape_2d.get_global_mouse_position()
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("feed") :
		cpu_particles_2d.emitting = true
		cpu_particles_2d.position = collision_shape_2d.get_global_mouse_position()
		
		
	if Input.is_action_just_released("feed"):
		cpu_particles_2d.emitting = false
