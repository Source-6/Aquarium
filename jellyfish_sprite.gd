extends AnimatedSprite2D


@export var speedY : float
@export var speedX : float
var randFlip

var startPos : Vector2
var randPos : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randPos = randf_range(30,330)
	startPos = Vector2(randPos, 180)
	position = startPos
	randFlip = randi()%2
	print(randFlip)
	if randFlip == 0 :
		flip_h = false
		
		
	elif randFlip == 1 : 
		flip_h = true
		speedX *= -1
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speedY * delta
	position.x += speedX * delta
