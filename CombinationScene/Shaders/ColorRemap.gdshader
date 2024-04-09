shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D summer_gradient;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	COLOR.a = color.a;
	vec3 new_RGB = texture(summer_gradient, vec2(color.r, 0)).rgb;
	COLOR.rgb = new_RGB;
}

