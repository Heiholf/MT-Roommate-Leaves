shader_type canvas_item;

const int count = 100;
const int face_count = 300;
const int vertex_count = 900;
const float MAX = 100000.0f;

uniform vec2 points[count];

uniform vec2 vertices[vertex_count];

float area(vec2 corners[3]){
	return abs(corners[0].x * (corners[1].y - corners[2].y) + corners[1].x * (corners[2].y - corners[0].y) + corners[2].x * (corners[0].y - corners[1].y))* 0.5f;
}

bool is_in_triangle(vec2 point, vec2 corners[3]){
	float A = area(corners);
	vec2 copy[3] = corners;
	copy[0] = point;
	float A1 = area(copy);
	copy[0] = corners[0];
	copy[1] = point;
	float A2 = area(copy);
	copy[1] = corners[1];
	copy[2] = point;
	float A3 = area(copy);
	
	return (A1 + A2 + A3) - A < 0.001f;
	
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	bool success = false;
	for(int i = 0; i < face_count; i += 3) {
		
		if(vertices[i].x == -1.0f){
			continue;
		}
		vec2 vector[3] = vec2[3](vertices[i], vertices[i+1], vertices[i+2]);
		if(is_in_triangle(SCREEN_UV, vector)){
			vec2 center = (vertices[i] + vertices[i+1] +  vertices[i+2]) * 0.333333333f;
			COLOR.rg = center;
			COLOR.ba = vec2(1.0f);
			COLOR.rgb = vec3(float(i) / float(face_count * 2) + 0.5f);
			success = true;
			break;
		}
	}
	
	if(!success){
		COLOR.rgb = vec3(0.0f);
		COLOR.a = 1.0f;
	}
	
	/*
	vec2 nearest[3] = {
		vec2(MAX, MAX),
		vec2(MAX, MAX),
		vec2(MAX, MAX)
	};
	
	for(int i = 0; i < count; i++){
		vec2 delta = points[i] - SCREEN_UV;
		float dist = length(delta);
		
		if(dist < length(nearest[0] - SCREEN_UV)){
			nearest[2] = nearest[1];
			nearest[1] = nearest[0];
			nearest[0] = points[i];
			continue;
		}
		
		if(dist < length(nearest[1] - SCREEN_UV)){
			nearest[2] = nearest[1];
			nearest[1] = points[i];
			continue;
		}
		
		if(dist < length(nearest[2] - SCREEN_UV)){
			nearest[2] = points[i];
			continue;
		}
	}
	
	vec2 center = (nearest[0] + nearest[1] + nearest[2]) / 3.0f;
	
	if(is_in_triangle(SCREEN_UV, nearest)){
		COLOR.rg = center;
		COLOR.ba = vec2(1.0f);
	} else {
		COLOR.rgb = vec3(0.0f);
		COLOR.a = 1.0f;
	}*/
	
	
	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
