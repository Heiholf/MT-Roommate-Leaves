shader_type canvas_item;
render_mode blend_mix;

uniform bool is_winter;

uniform float start_time = 0;
uniform float time_at_fall_start = 0;
uniform sampler2D cutout;
uniform sampler2D noise_texture;
uniform sampler2D summer_fall_gradient;

#include "settings.gdshaderinc"
#include "functions.gdshaderinc"



void fragment() {
	
	//TODO: Fix weird time offset or declare bug as a feature 
	// Time in Seconds since start
	float time_since_start = TIME - start_time;
	// Time in Seconds since start of fall 
	float time_after_fall_start = time_since_start - time_at_fall_start;

	// Mapping current Time to color of leaves (Transition Summer -> Fall)
	float scaled_time_after_fall_start = time_after_fall_start / transition_duration;
	float clamped_scaled_time_after_fall_start = clamp(scaled_time_after_fall_start, 0.0f, 1.0f);
	// New: Gradient Mapping
	vec4 tree_color_sf = texture(summer_fall_gradient, vec2(clamped_scaled_time_after_fall_start, 0.0f));

	// Instantanious Transition Fall -> Winter
	vec4 tree_color_sfw = mix(tree_color_sf, winter_color, float(is_winter));
	
	
	if(blobs) {
		vec2 offset = TIME * blob_speed * SCREEN_PIXEL_SIZE;
		vec2 Local_UV = translate(SCREEN_UV, offset);
		vec2 region = discretizeVec2(Local_UV / SCREEN_PIXEL_SIZE, vec2(blob_size)) * SCREEN_PIXEL_SIZE;
		vec2 region_delta = Local_UV - region;
		float time_region = discretize(TIME, blob_duration);
		float time_delta = TIME - time_region  + random(region) * blob_duration;
		bool is_blob = one_in_n(region + vec2(time_region), blob_rarity);
		if(is_blob) {
			float local_blob_intensity = 1.0f - circle(region_delta / blob_size / SCREEN_PIXEL_SIZE, vec2(0.5f) , 0.0f,0.2f);
			float alpha = blob_alpha_curve(clamp(time_delta / blob_duration, 0.0f, 1.0f));
			tree_color_sfw.rgb -= vec3(local_blob_intensity * blob_intensity * alpha);
		}
		
	}
	
	
	if(flimmern){
		tree_color_sfw += (random( floor(SCREEN_UV / SCREEN_PIXEL_SIZE.x / flimmer_size) * flimmer_size * SCREEN_PIXEL_SIZE.x + vec2(TIME)) - 0.5f)  * flimmer_intensity;
	}

	// Cropping tree
	vec4 tree_mask_uv = texture(cutout, SCREEN_UV);
	vec3 final_RGB = tree_mask_uv.r * vec3(tree_color_sfw.xyz);
	
	if(is_winter){
		final_RGB = final_RGB * (1.0f - tree_mask_uv.b);
	}
	
	
	COLOR.rgb = final_RGB;

	
}
