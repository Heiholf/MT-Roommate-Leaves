shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


uniform float r;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float x,y,xx,yy,rr=r*r,dx,dy,w,w0;
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
	float xs = texture_size.x, ys = texture_size.y;
	w0=0.3780/pow(r,1.975);
	vec2 p;
	vec4 col=vec4(0.0,0.0,0.0,0.0);
	vec2 pos = SCREEN_UV * 2.0 - vec2(1.0);
	dx =1.0/xs;
	x=-r;
	p.x=0.5+(pos.x*0.5)+(x*dx);
    for (;x<=r;x++,p.x+=dx){
		xx=x*x;
		dy=1.0/ys;
		y=-r;
		p.y=0.5+(pos.y*0.5)+(y*dy);
		for (;y<=r;y++,p.y+=dy){
			yy=y*y;
			if (xx+yy<=rr){
				w=w0*exp((-xx-yy)/(2.0*rr));
				col+=texture(screen_texture,p)*w;
			}
		}
	}
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
