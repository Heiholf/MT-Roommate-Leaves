@tool
extends Node


@export
var material : ShaderMaterial = null

@export
var cutout: Texture2D = null



@export
var summerFallGradient: GradientTexture1D = null

@export
var noiseTexture: Texture2D = null

@export
var particles: GPUParticles2D = null

var skips: int = 0;

# Leaves ource: https://www.colourbox.com/image/leaf-texture-image-4396217

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_parameter("cutout", cutout)
	material.set_shader_parameter("start_time", Time.get_ticks_msec() / 1000)
	material.set_shader_parameter("time_at_fall_start", 100000000000)
	material.set_shader_parameter("is_winter", false)
	material.set_shader_parameter("summer_fall_gradient", summerFallGradient)
	material.set_shader_parameter("noise_texture", noiseTexture)
	if(particles != null):
		particles.emitting = false;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _input(event):
	if event.is_action_pressed("TimeStep"):
		skips += 1;
		print(skips)
		if skips == 1:
			if (particles != null):
				particles.emitting = true;
			material.set_shader_parameter("time_at_fall_start", Time.get_ticks_msec() / 1000)
			return
		if skips == 2:
			if (particles != null):
				particles.emitting = false;
			material.set_shader_parameter("is_winter", true)
		
