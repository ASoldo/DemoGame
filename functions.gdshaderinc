float draw_circle(vec2 uv, float size, float edge) {
	edge = max(edge, 1.0e-8);
	float dist = length(uv);
	return clamp((1.0 - dist / size)/ edge, 0.0, 1.0);
}

float draw_circle_outline(vec2 uv, float radius, float edge_width) {
    float dist = length(uv);
    float outer_edge = step(radius - edge_width, dist);
    float inner_edge = step(radius, dist);
    return outer_edge * (1.0 - inner_edge);
}

float draw_circle_outline_smooth(vec2 uv, float radius, float edge_width) {
float dist = length(uv);
float outer_edge = smoothstep(radius - edge_width, radius, dist);
float inner_edge = smoothstep(radius, radius + edge_width, dist);
return outer_edge * (1.0 - inner_edge);
}

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

vec3 calculate_final_color(vec2 uv, vec2 circle_center, float circle_radius, float circle_edge, bool circle_outline, vec4 circle_col, vec4 square_col, vec2 sq_center, vec2 sq_size, vec2 tri_center, vec2 tri_size) {
    vec2 circle_uv = uv - circle_center;
    vec3 shape_color = circle_col.rgb;
    float circle_mask = 0.0;

    if (circle_outline) {
        circle_mask = draw_circle_outline(circle_uv, circle_radius, circle_edge);
    } else {
        circle_mask = draw_circle(circle_uv, circle_radius, circle_edge);
    }

    vec2 square_uv = uv - sq_center;
    bool in_square = abs(square_uv.x) <= sq_size.x && abs(square_uv.y) <= sq_size.y;

    vec2 tri_v1 = tri_center + vec2(-tri_size.x, -tri_size.y);
    vec2 tri_v2 = tri_center + vec2(tri_size.x, -tri_size.y);
    vec2 tri_v3 = tri_center + vec2(0.0, tri_size.y);
    bool in_triangle = is_point_in_triangle(uv, tri_v1, tri_v2, tri_v3);

    vec3 final_color = vec3(0.0);

    if (in_triangle) {
        // If inside triangle, make it transparent
        return final_color;
    }

    if (in_square) {
        final_color = square_col.rgb;
    }

    if (circle_mask > 0.0) {
        if (in_square) {
            final_color = square_col.rgb;
        } else {
            final_color = shape_color;
        }
    }

    return final_color * circle_mask;
}