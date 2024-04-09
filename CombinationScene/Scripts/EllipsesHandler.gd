extends Node

@export 
var ellipses_asset : PackedScene;

@export 
var ellipses_count : int;

@export
var size_curve: Curve;

@export
var color_speed_curve: Curve;

func _ready():
	seed(1)
	for i in range(ellipses_count):
		
		var ellipse : Node2D = ellipses_asset.instantiate()
		add_child(ellipse)
		var size : float = size_curve.sample_baked(float(i)/ellipses_count) / 100
		var direction: Vector2 = Vector2.from_angle(randf_range(0, 2*PI))
		var distance : float = 1 / size;
		ellipse.scale = Vector2(size, size)
		ellipse.position = direction * distance;
		#ellipse.rotation = 
		ellipse.color = Color.from_hsv(0,0, randf_range(0,1));
		
		ellipse.update_color()
		
		
		

func _process(delta):
	pass
