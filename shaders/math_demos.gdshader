// Checkerboard pattern in Godot shader
shader_type canvas_item;

uniform float scale = 8.0;
uniform vec3 color1: source_color = vec3(1.0);
uniform vec3 color2: source_color = vec3(0.0);

void fragment() {
    vec2 uv = UV * scale;
    float checker = mod(floor(uv.x) + floor(uv.y), 2.0);
    vec3 color = mix(color1, color2, checker); // Alternate black and white squares
    COLOR = vec4(color, 1.0);
}
