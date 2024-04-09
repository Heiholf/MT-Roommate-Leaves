shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 box = vec2(3.0f);

void fragment() {
	
	vec4 sum = vec4(0.0f);
	float count = 0.0f;
	vec2 delta = box * SCREEN_PIXEL_SIZE;
	vec2 offset = -delta * 0.5f;
	
	for(float i = 0.0f; i < box.x; i++){
		for(float j = 0.0f; j < box.y; j++){
			sum += texture(screen_texture, SCREEN_UV + offset + delta * vec2(i,j));
			count++;
		}
	}
	
	COLOR = sum / count;
	
	
	
	
	// Called for every pixel the material is visible on.
}
