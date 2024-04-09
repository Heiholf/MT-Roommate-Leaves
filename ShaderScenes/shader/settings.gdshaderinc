uniform vec4 winter_color : source_color = vec4(0.800000, 0.774800, 0.728000, 1.000000);
uniform float transition_duration = 1.00000;



const bool flimmern = true;
const float flimmer_intensity = 0.07f;
const float flimmer_size = 10.0f;


const bool blobs = true;
const float blob_rarity = 10.0f;
const float blob_size = 200.0f;
const vec2 blob_speed = vec2(-60.0f);
const float blob_intensity = 0.05f;
const float blob_duration = 10.0f;

float blob_alpha_curve(float t) {
	return 20.0f * t * t * (1.0f - t) * (1.0f - t);
}

