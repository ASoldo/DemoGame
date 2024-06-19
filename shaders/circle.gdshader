shader_type canvas_item;

uniform vec4 circle_color : source_color; // Color of the circle
uniform vec4 square_color : source_color; // Color of the square
uniform vec2 center = vec2(0.5, 0.5); // Center of the circle
uniform float outline_radius = 0.3; // Radius of the circle
uniform float outline_thickness = 0.01;
uniform bool outline = true;
uniform vec2 square_center = vec2(0.5, 0.5); // Center of the square
uniform vec2 square_size = vec2(0.2, 0.2); // Size of the square (half extents)
uniform vec2 triangle_center = vec2(0.5, 0.5); // Center of the triangle
uniform vec2 triangle_size = vec2(0.2, 0.2); // Size of the triangle (half extents)

#include "res://functions.gdshaderinc"

void fragment() {
    vec2 uv = UV;
    vec3 final_color = calculate_final_color(uv, center, outline_radius, outline_thickness, outline, circle_color, square_color, square_center, square_size, triangle_center, triangle_size);
    
    if (length(uv - center) <= outline_radius || outline) {
        if (final_color != vec3(0.0)) {
            COLOR = vec4(final_color, circle_color.a);
        } else {
            discard; // Discards the fragment inside the triangle
        }
    } else {
        discard; // Discards the fragment outside the circle
    }
}