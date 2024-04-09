shader_type particles;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0)
	s = 305420679;
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0)
		s += 2147483647;
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}

void start() {
	uint seed = NUMBER + RANDOM_SEED;
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
	vec2 rand;
	while(true){
		rand.x = rand_from_seed(seed);
		rand.y = rand_from_seed(seed);
		vec4 sample = texture(screen_texture, rand);
		
		break;
		
	}
	TRANSFORM[3].xyz = vec3(100.0, 200.0, 0.0);
	
	// Called when a particle is spawned.
}

void process() {
	VELOCITY = vec3(0.0);
	// Called every frame on existing particles (according to the Fixed FPS property).
}


