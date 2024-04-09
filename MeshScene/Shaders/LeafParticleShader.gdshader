shader_type particles;

uniform sampler2D screen_texture;

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
	/*uint seed = NUMBER + RANDOM_SEED;
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
	vec2 rand;
	while(true){
		rand.x = rand_from_seed(seed);
		rand.y = rand_from_seed(seed);
		vec4 sample = texture(screen_texture, rand);
		if (sample.b < 30.0) {
			TRANSFORM[3].xy = rand * texture_size - texture_size * 0.5;
			break;
		}
		
	}*/
	
	TRANSFORM[3].xy = vec2(300.0);
	VELOCITY.y = 300.0;
	
	
	
	// Called when a particle is spawned.
}

void process() {
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
	VELOCITY = (texture(screen_texture, TRANSFORM[3].xy / texture_size).xyz - vec3(0.5)) * 300.0;
	// Called every frame on existing particles (according to the Fixed FPS property).
}


