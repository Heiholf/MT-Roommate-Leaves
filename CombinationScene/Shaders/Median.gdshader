shader_type canvas_item;


const int BUCKET_COUNT = 10;

const float radius = 30.0f;
const float square_area = 4.0f * radius * radius;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	
	int[BUCKET_COUNT] buckets;
	
	int counted = 0;
	
	for(float delta_x = -radius; delta_x < radius; delta_x += 1.0f) {
		for(float delta_y = -radius; delta_y < radius; delta_y += 1.0f) {
			float dist = length(vec2(delta_x, delta_y));
			if (dist > radius) {
				continue;
			}
			counted++;
			vec2 texture_position = vec2(delta_x, delta_y) * SCREEN_PIXEL_SIZE;
			vec4 color = texture(screen_texture, texture_position);
			//vec3 hsv = rgb2hsv(color.rgb);
			//float value = hsv.z;
			float value = color.r;
			float bucket = floor(value * float(BUCKET_COUNT));
			buckets[int(bucket)]++;
		}
	}
	
	int sum = 0;
	
	for(int i = 0; i < BUCKET_COUNT; i++) {
		int next_sum = sum + buckets[i];
		if (next_sum > counted / 2) {
			//COLOR.rgb = hsv2rgb(vec3(vec2(0.0f), float(i) / float(BUCKET_COUNT)));
			COLOR.rgb = vec3(float(i) / float(BUCKET_COUNT));
			COLOR.a = texture(screen_texture, SCREEN_UV).a;
			break;
		}
	}
	
}


