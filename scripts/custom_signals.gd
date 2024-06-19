extends Node2D

class_name MyNode

signal soki

@export var myNodeName: String = ""
@export var myNodeAge: int = 0

func _ready() -> void:
	print_debug("MyNoded loaded")

func hello_soldo() -> void:
	print_debug("Hello soldo soki event was triggered")

func _on_soki() -> void:
	print_debug("soki event")
