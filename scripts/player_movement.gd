extends Area2D

class_name PlayerMovement
# How fast the player will move (pixels/sec).
@export var speed = 600 

var screen_size # Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_key_pressed(KEY_UP):
		velocity.y -= 1
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += 1
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

