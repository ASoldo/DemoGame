extends RefCounted

class_name Animal
@export var Name: String
@export var Category: String
@export var SnakeLength: float

func create(name: String, category: String, snake_length: float) -> void:
	self.Name = name
	self.Category = category
	self.SnakeLength = snake_length
	
func eat() -> void:
	print_debug(str(self.Name, " is eating something"))
