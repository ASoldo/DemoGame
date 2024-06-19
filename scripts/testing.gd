extends Node

class_name Testing

@export var number: int = 5
@export var string: String = "Soki"

@export var numberArray: Array[int] = []
@export var nodeArray: Array[Node] = []
var persons: Array[Person]

var dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug(str("Number: ", number))
	print_debug(str("String: ", string))

	for i in numberArray:
		print_debug(i)

	print_debug(numberArray)
	
	var andrija = Person.new()
	andrija.Name = "Andrija"
	andrija.Age = 34
	persons.append(andrija)
	
	var vili = Person.new()
	vili.Name = "vili"
	vili.Age = 999
	persons.append(vili)
	
	print_debug(persons)
	for person in persons:
		print_debug(person.Name)
		print_debug(str(person.Age))
	
	dictionary.my_name = "Andrijato"
	print_debug(dictionary.my_name)
	
	var snake = Animal.new()
	snake.create("Soldatav", "Snake", 1.94)
	snake.eat()
	
	print_debug(str("Snake Name: ", snake.Name))
	print_debug(str("Snake Category: ", snake.Category))
	print_debug(str("Snake Lenght: ", snake.SnakeLength))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

class Person:
	var Name: String
	var Age: int

