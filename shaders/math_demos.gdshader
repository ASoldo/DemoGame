shader_type canvas_item;

uniform vec3 front_wave_color : source_color = vec3(1.0, 0.0, 0.0); // Color for the front sine wave
uniform vec3 front_fill_color : source_color = vec3(0.0, 0.0, 1.0); // Fill color for the front sine wave
uniform vec3 back_wave_color : source_color = vec3(0.0, 1.0, 0.0); // Color for the back sine wave
uniform vec3 back_fill_color : source_color = vec3(1.0, 1.0, 0.0); // Fill color for the back sine wave

uniform float frequency = 1.0;
uniform float amplitude = 0.5;
uniform vec2 offset;
uniform vec2 center = vec2(0.5, 0.5); // Center of the circle
uniform float radius = 0.4; // Radius of the circle
uniform bool direction = true; // Scroll direction
uniform float speed = 0.1; // Speed of scrolling
uniform bool use_circle = true; // Use circle mask

void fragment() {
    vec2 uv = UV;
    
    // Calculate time-based scrolling offsets
    float time_offset = TIME * speed;
    float scroll_offset_front = direction ? time_offset : -time_offset;
    float scroll_offset_back = direction ? -time_offset : time_offset;
    
    // Calculate the sine wave values with scrolling offsets
    float sine_wave_front = amplitude * sin(2.0 * PI * frequency * (uv.x - offset.x + scroll_offset_front)) + offset.y;
    float sine_wave_back = amplitude * sin(2.0 * PI * frequency * (uv.x - offset.x + scroll_offset_back)) + offset.y;
    
    if (use_circle) {
        // Calculate the distance from the center to apply the circle mask
        float dist = distance(uv, center);
        
        // Apply the circle mask
        if (dist <= radius) {
            if (uv.y > sine_wave_front) {
                COLOR = vec4(front_fill_color, 1.0); // Filled area for the front sine wave
            } else if (abs(uv.y - sine_wave_front) < 0.01) {
                COLOR = vec4(front_wave_color, 1.0); // Front sine wave line
            } else if (uv.y > sine_wave_back) {
                COLOR = vec4(back_fill_color, 1.0); // Filled area for the back sine wave
            } else if (abs(uv.y - sine_wave_back) < 0.01) {
                COLOR = vec4(back_wave_color, 1.0); // Back sine wave line
            } else {
                discard; // Transparent area
            }
        } else {
            discard; // Discards the fragment outside the circle
        }
    } else {
        // No circle mask, use whole UV space
        if (uv.y > sine_wave_front) {
            COLOR = vec4(front_fill_color, 1.0); // Filled area for the front sine wave
        } else if (abs(uv.y - sine_wave_front) < 0.01) {
            COLOR = vec4(front_wave_color, 1.0); // Front sine wave line
        } else if (uv.y > sine_wave_back) {
            COLOR = vec4(back_fill_color, 1.0); // Filled area for the back sine wave
        } else if (abs(uv.y - sine_wave_back) < 0.01) {
            COLOR = vec4(back_wave_color, 1.0); // Back sine wave line
        } else {
            discard; // Transparent area
        }
    }
}
