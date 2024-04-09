shader_type canvas_item;


uniform vec4 color = vec4(1.0f);
uniform float time_offset = 0.0f;
uniform float color_amplitude = 0.05f;
uniform float color_period = 2;
const vec4 WHITE = vec4(1.0f);
const float invPI = 1.0f / (2.0f * PI);


void fragment() {
	vec4 original_value = texture(TEXTURE, UV);
	float seconds = TIME + time_offset;
	float offset = sin(seconds * invPI / color_period) * color_amplitude;
	
	
	
	COLOR = color * original_value + WHITE * offset;
}
