@tool
# Having a class name is required for a custom node.
class_name VisualShaderNodeColorInterpolate
extends VisualShaderNodeCustom


func _get_name():
	return "ColorInterpolate"


func _get_category():
	return "Color"


func _get_description():
	return "Interpolate between two Colors"


func _get_return_icon_type():
	return PORT_TYPE_VECTOR_4D


func _get_input_port_count():
	return 3


func _get_input_port_name(port):
	var x = "Unset"
	match port:
		0: x = "Color1"
		1: x = "Color2"
		2: x = "k"
	return x


func _get_input_port_type(port):
	var x = PORT_TYPE_SCALAR
	match port:
		0: x = PORT_TYPE_VECTOR_4D
		1: x = PORT_TYPE_VECTOR_4D
		2: x = PORT_TYPE_SCALAR
	return x
	
func _get_input_port_default_value(port):
	var x = 0
	match port:
		0: x = Vector4.ZERO
		1: x = Vector4.ONE
		2: x = 0
	return x


func _get_output_port_count():
	return 1


func _get_output_port_name(port):
	return "result"


func _get_output_port_type(port):
	return PORT_TYPE_VECTOR_4D


func _get_code(input_vars, output_vars,
		mode, type):
	var color1 = input_vars[0]
	var color2 = input_vars[1]
	var k = input_vars[2]
	return "%s = %s * %s + %s * (1.0f - %s);" % [output_vars[0], color2, k, color1, k]
