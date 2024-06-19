shader_type canvas_item;

uniform vec3 wave_color : source_color = vec3(1.0, 0.0, 0.0); // Red color for the wave
uniform vec3 fill_color : source_color = vec3(0.0, 0.0, 1.0); // Blue color for the fill
uniform float frequency = 1.0;
uniform float amplitude = 0.0;
uniform vec2 offset = vec2(0.0, 0.5);
uniform vec2 center = vec2(0.5, 0.5); // Center of the circle
uniform float radius = 0.4; // Radius of the circle

void fragment() {
    vec2 uv = UV;
    
    // Calculate the sine wave value
    float sine_wave = amplitude * sin(2.0 * PI * frequency * (uv.x - offset.x)) + offset.y;
    
    // Calculate the distance from the center to apply the circle mask
    float dist = distance(uv, center);
    
    // Apply the circle mask
    if (dist <= radius) {
        // Fill the area below the sine wave
        if (uv.y > sine_wave) {
            COLOR = vec4(fill_color, 1.0); // Filled area
        } else if (abs(uv.y - sine_wave) < 0.01) {
            COLOR = vec4(wave_color, 1.0); // Sine wave line
        } else {
            discard; // Transparent area
        }
    } else {
        discard; // Discards the fragment outside the circle
    }
}
