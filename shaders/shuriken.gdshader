shader_type canvas_item;

uniform vec4 triangle_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Color of the triangles
uniform vec2 center = vec2(0.5, 0.5); // Center of the shape
uniform float circle_radius = 0.1; // Radius of the circle
uniform float triangle_scale = 0.5; // Scale of the triangles
uniform float pointiness = 1.5; // Factor to make the vertices pointy

// Function to check if a point is inside a triangle
bool is_point_in_triangle(vec2 pt, vec2 v1, vec2 v2, vec2 v3) {
    float d1, d2, d3;
    bool has_neg, has_pos;

    d1 = (pt.x - v2.x) * (v1.y - v2.y) - (v1.x - v2.x) * (pt.y - v2.y);
    d2 = (pt.x - v3.x) * (v2.y - v3.y) - (v2.x - v3.x) * (pt.y - v3.y);
    d3 = (pt.x - v1.x) * (v3.y - v1.y) - (v3.x - v1.x) * (pt.y - v1.y);

    has_neg = (d1 < 0.0) || (d2 < 0.0) || (d3 < 0.0);
    has_pos = (d1 > 0.0) || (d2 > 0.0) || (d3 > 0.0);

    return !(has_neg && has_pos);
}

void fragment() {
    vec2 uv = UV - center;

    // Calculate the vertices of the triangles
    float angle = atan(uv.y, uv.x);
    float dist = length(uv);

    vec2 vertices[8];
    for (int i = 0; i < 8; ++i) {
        float theta = radians(45.0 * float(i));
        float scale = i % 2 == 0 ? triangle_scale * pointiness : triangle_scale;
        vertices[i] = vec2(cos(theta), sin(theta)) * scale;
    }

    // Check if the point is inside the circle
    if (dist <= circle_radius) {
        discard; // Discards the fragment inside the circle
    }

    vec4 color = vec4(0.0);

    // Check if the point is inside any of the triangles
    for (int i = 0; i < 8; ++i) {
        vec2 v1 = vertices[i];
        vec2 v2 = vertices[(i + 1) % 8];
        vec2 v3 = vec2(0.0);
        if (is_point_in_triangle(uv, v1, v2, v3)) {
            color = triangle_color;
            break;
        }
    }

    // Set the final color
    COLOR = color;
}
