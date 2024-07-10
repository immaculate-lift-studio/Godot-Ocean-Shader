shader_type spatial;

uniform vec3 albedo : source_color;
uniform sampler2D water_texture1; // First scrolling water texture
uniform sampler2D water_texture2; // Second scrolling water texture
uniform sampler2D noise_texture;  // Noise texture for wave randomness
uniform vec2 scroll_speed1 = vec2(0.05, 0.0); // Speed of the first texture scrolling
uniform vec2 scroll_speed2 = vec2(-0.03, 0.0); // Speed of the second texture scrolling
uniform float blend_factor = 0.5; // Controls the blend between the two textures
uniform vec2 scale1 = vec2(1.0, 1.0); // Scale of the first texture
uniform vec2 scale2 = vec2(1.0, 1.0); // Scale of the second texture
uniform float wave_strength = 1.0; // Controls the height of the waves
uniform float wave_scale = 0.02; // Scale of the noise for wave generation
uniform int pixelation_level = 64; // Level of pixelation

void vertex() {
    float noise_value = texture(noise_texture, VERTEX.xz * wave_scale).r;
    float wave = sin((VERTEX.x + VERTEX.z) * 0.2 + TIME + noise_value * 10.0) * wave_strength;
    VERTEX.y += wave;
}

void fragment() {
    vec2 scaledUV1 = UV * scale1;
    vec2 scaledUV2 = UV * scale2;

    vec2 scrolledUV1 = scaledUV1 + scroll_speed1 * TIME;
    vec2 scrolledUV2 = scaledUV2 + scroll_speed2 * TIME;

    scrolledUV1 = mod(scrolledUV1, vec2(1.0, 1.0));
    scrolledUV2 = mod(scrolledUV2, vec2(1.0, 1.0));

    scrolledUV1 = floor(scrolledUV1 * float(pixelation_level)) / float(pixelation_level);
    scrolledUV2 = floor(scrolledUV2 * float(pixelation_level)) / float(pixelation_level);

    vec4 water_color1 = texture(water_texture1, scrolledUV1);
    vec4 water_color2 = texture(water_texture2, scrolledUV2);

    vec4 blended_water_color = mix(water_color1, water_color2, blend_factor);

    ALBEDO = blended_water_color.rgb * albedo;
    METALLIC = 0.0;
    ROUGHNESS = 1.0;
}

