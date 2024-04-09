shader_type canvas_item;

uniform sampler2D cutout;

void fragment() {
	
	
	COLOR.rgb = texture(TEXTURE, SCREEN_UV).rgb;
	COLOR.a = texture(cutout, SCREEN_UV).r;
}
