extends Node2D
class_name  Counter
@export var counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextEdit.text = str(counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func _on_button_pressed() -> void:
	$TextEdit.text = increment_counter(1)
	$"../MyNode".soki.emit()

func increment_counter(increment: int) -> String:
	counter += increment
	return str(counter)
