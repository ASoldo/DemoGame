shader_type canvas_item;
uniform float radius = 0.5;
uniform vec4 color: source_color;
uniform float outline_width = 0.1;
uniform vec4 inner_color: source_color;
uniform vec3 outer_color: source_color;
uniform float border_smoothness = 0.01;
uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	vec2 center = vec2(0.5, 0.5);
	
	float dist = sqrt(pow(uv.x - center.x, 2.0) + pow(uv.y - center.y, 2.0));
	float edge = smoothstep(radius, dist, border_smoothness);
	if(dist < radius - outline_width || dist > radius + outline_width) {
		//COLOR = vec4(inner_color, 1.0);
		discard;
		
	} else {
		vec4 tex_color = texture(tex, uv);
		COLOR = mix(tex_color, inner_color, 0.5);
	}
	

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
