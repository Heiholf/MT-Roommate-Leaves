@tool
extends Node

@export
var material: ShaderMaterial = null;

@export 
var summer_gradient: GradientTexture1D = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_parameter("summer_gradient", summer_gradient);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
