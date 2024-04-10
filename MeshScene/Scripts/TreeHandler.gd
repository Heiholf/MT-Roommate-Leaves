extends Node

@export_category("Settings")
@export_range(0, 400)
var vertex_count : int = 100

@export_range(0.05, 2)
var circleness : float = 0.2

@export_range(0, 100)
var random_wiggle_strength: float = 20

@export_range(0, 100)
var directional_wiggle_strength: float = 20

@export_range(0, 2)
var directional_wiggle_frequency: float = 1


@export_category("References")


@export 
var summer_gradient: Gradient

var points : Array = []

var delaunay: Delaunay = null
var triangles: Array = []

var screen = Vector2(DisplayServer.window_get_size())

func random_point():
	var angle = randf() * TAU
	var distance = randf() ** circleness
	var vector = Vector2.from_angle(angle) * distance * 0.85
	vector += Vector2.ONE
	vector /= 2
	return vector
	

func scatter_points(delaunay: Delaunay):
	for i in range(vertex_count):
		var point = random_point()
		delaunay.add_point(point)
		

func show_triangle(triangle: Delaunay.Triangle):
	var poly = Polygon2D.new()
	var p = PackedVector2Array()
	p.append(triangle.a * screen)
	p.append(triangle.b * screen)
	p.append(triangle.c * screen)
	#p.append(triangle.a * screen)
	poly.polygon = p
	poly.color = Color.WHITE * summer_gradient.sample(1 -((triangle.a + triangle.b + triangle.c) / 3).y)
	poly.color = summer_gradient.sample(randf())
	poly.color.a = 1
	poly.color
	poly.antialiased
	poly.visibility_layer = 2
	add_child(poly)
	
	
func update_triangles():
	screen = Vector2(DisplayServer.window_get_size())
	print("Update")
	for child in get_children():
		remove_child(child)
	for triangle in triangles:
		if !delaunay.is_border_triangle(triangle):
			show_triangle(triangle)

func set_points():
	delaunay = Delaunay.new()
	scatter_points(delaunay)
	triangles = delaunay.triangulate()
	update_triangles()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	InputMap.load_from_project_settings()
	seed(2)
	set_points()
	pass # Replace with function body.

func random (uv: Vector2):
	return fposmod(sin(Vector2(12.9898,78.233).dot(uv)) * 43758.5453123, 1.0);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		for i in range(0, 3):
			var dist_from_center = (Vector2(child.polygon[i] - screen / 2).length_squared() + 1) / screen.length_squared()
			var dist_factor = 0.1 / (dist_from_center + 0.1)
			var random_wiggle = Vector2.from_angle(random(child.polygon[i]) * 2 * PI) * delta * random_wiggle_strength * dist_factor
			var directional_wiggle = (child.polygon[i] - screen / 2).normalized() * sin(float(Time.get_ticks_msec()) / 1000 * 2 * PI * directional_wiggle_frequency) * delta * directional_wiggle_strength * dist_factor
			child.polygon[i] += random_wiggle + directional_wiggle
	pass

func _input(event):
	if event.is_action_pressed("Update"):
		update_triangles()
	if event.is_action_pressed("Reload"):
		set_points()
		
