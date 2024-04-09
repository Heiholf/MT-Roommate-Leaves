@tool
extends Node

@export
var material :  ShaderMaterial;

@export
var color : Color = Color.WHITE;

var time_offset : float = 0;
var color_amplitude: float = 0.05;
var color_period: float = 2;

func update_color():
	material.set_shader_parameter("color", color);

# Called when the node enters the scene tree for the first time.
func _ready():
	update_color()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
