float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

vec2 scale(vec2 uv, vec2 pivot, float x, float y)
{
	mat2 scale = mat2(vec2(x, 0.0), vec2(0.0, y));
	
	uv -= pivot;
	uv = uv * scale;
	uv += pivot;
	return uv;
}

vec2 translate(vec2 uv, vec2 delta) {
	return uv + delta;
}

float discretize(float value, float step) {
	return floor(value / step) * step;
}

vec2 discretizeVec2(vec2 value, vec2 step) {
	return floor(value / step) * step;
}

float circle(vec2 uv, vec2 position, float inner_radius, float outer_radius)
{
	vec2 delta = uv - position;
	float rs = dot(delta,delta);
	return smoothstep(inner_radius, outer_radius, rs);
}

bool one_in_n(vec2 seed, float n) {
	return random(seed) < 1.0f/n;
}
