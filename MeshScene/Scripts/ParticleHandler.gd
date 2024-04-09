extends GPUParticles2D

var start_screen_size: Vector2;
var start_scale: Vector2;
var start_position: Vector2;

func update_shader():
	process_material.set_shader_parameter("screen_texture", get_viewport().get_texture().get_image())

func update_scale():
	var current_screen_size : Vector2 = Vector2(DisplayServer.window_get_size());
	var ratio : Vector2 = current_screen_size / start_screen_size;
	var current_scale: Vector2 = start_scale * ratio;
	scale = current_scale;
	position = start_position * ratio;
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	start_scale = scale;
	start_position = position;
	start_screen_size = Vector2(DisplayServer.window_get_size());
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("Update"):
		update_scale()
		update_shader()
