extends Node

@export
var image: ImageTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Update"):
		var data = get_viewport().get_texture().get_image()
		image.set_image(data)
		print(type_string(typeof(data)))
