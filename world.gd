extends Node2D

@onready var ground = $"Ground"
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func _touchdown():
	return ground

func _on_timer_timeout():
	$Player._landing_mode()



func _on_ground_input_event(viewport, event, shape_idx):
	print(viewport)
	print(event)
	print(shape_idx)
	pass # Replace with function body.
