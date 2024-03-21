shader_type spatial;

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;

uniform vec3 albedo : source_color;
uniform vec3 albedo2 : source_color;
uniform float metallic : hint_range(0.0, 1.0) = 0;
uniform float roughness : hint_range(0.0, 1.0) = 0.2;
uniform sampler2D texture_normal;
uniform sampler2D texture_normal2;
uniform vec2 wave_direction = vec2(2.0,0.0);
uniform vec2 wave_direction2 = vec2(0.0,1.0);
uniform float time_scale : hint_range(0.0, 0.2, 0.005) = 0.025;
uniform float waveSpeed = 1.0;
uniform float waveHeight = 1.0;
uniform float waveFrequency = 1.0;

float fresnal(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void vertex() {
    // Calculate the wave phase
    float phase = waveSpeed * TIME;
    // Apply a sine wave to the vertex position
    VERTEX.y += sin(VERTEX.x * waveFrequency + phase) * waveHeight;
    // You can add more complexity by combining multiple sine waves
    VERTEX.y += sin(VERTEX.z * waveFrequency * 0.5 - phase) * (waveHeight * 0.5);
}


void fragment() {
	vec2 time = (TIME * 0.1 * wave_direction) * time_scale;
	vec2 time2 = (TIME * 0.1 * wave_direction2) * time_scale;
	float fresnal = fresnal(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(albedo, albedo2, fresnal);

	vec3 normal_blend = mix(texture(texture_normal,UV + time).rgb, texture(texture_normal2,UV + time2).rgb, 0.5);
	
	ALBEDO = surface_color;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	NORMAL_MAP = normal_blend;
}
