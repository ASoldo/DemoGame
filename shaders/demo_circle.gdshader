shader_type canvas_item;

// Circle equation: (x - a)^2 + (y - b)^2 = r^2

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius = 0.5;
uniform float border = 0.003;
uniform float value = 0.75; // Value between 0 and 1 representing the percentage of the gauge
uniform vec4 color_start : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Start color of the gradient
uniform vec4 color_end : source_color = vec4(0.0, 0.0, 1.0, 1.0);   // End color of the gradient
uniform float spread = 0.5; // Value between 0 and 1 representing the gradient spread
uniform float line_angle = 0.0; // Angle of the line in radians
uniform float line_width = 0.01; // Width of the line

void vertex() {
    // Called for every vertex the material is visible on.
}

bool circle_outline(vec2 uv, vec2 position, float circle_size, float border_size) {
    float distance = sqrt(pow(uv.x - position.x, 2.0) + pow(uv.y - position.y, 2.0));
    return distance > (circle_size - border_size) && distance < (circle_size + border_size);
}

bool is_filled(vec2 uv, vec2 position, float circle_size, float fill_value) {
    vec2 direction = uv - position;
    float angle =float(-1) * atan(direction.x, direction.y);
    if (angle < 0.0) angle += 2.0 * PI; // Normalize angle to range [0, 2*PI]
    float fill_angle = 2.0 * PI * fill_value; // Convert fill value to angle
    return angle <= fill_angle;
}

bool is_on_line(vec2 uv, vec2 position, float line_angles, float line_widths) {
    vec2 direction = uv - position;
    float angle = float(-1) * atan(direction.x, direction.y);
    if (angle < 0.0) angle += 2.0 * PI; // Normalize angle to range [0, 2*PI]
    float half_width = line_widths / 2.0;
    float distance = length(direction);
    return distance <= radius && (abs(angle - line_angles) < half_width || abs(angle - (line_angles + 2.0 * PI)) < half_width);
}

void fragment() {
    vec2 uv = UV;
    
    bool draw_line = is_on_line(uv, center, line_angle, line_width);
    bool draw_circle = circle_outline(uv, center, radius, border);
    bool fill_circle = is_filled(uv, center, radius, value);

    if (draw_line) {
        COLOR = vec4(1.0, 1.0, 1.0, 1.0); // Color for the line
    } else if (draw_circle && fill_circle) {
        float distance = length(uv - center);
        float adjusted_border = border * spread; // Adjust border by spread factor
        float t = smoothstep(radius - adjusted_border, radius, distance); // Interpolation factor for gradient
        vec4 color = mix(color_start, color_end, t); // Interpolated color
        COLOR = color;
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent for unfilled part
    }
}
