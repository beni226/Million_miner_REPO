shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, filter_nearest;

uniform vec2 lights[100];
uniform int numOfLights = 1;
uniform vec4 modulateColor : source_color = vec4(0.0);
//uniform vec4 blackPoint : source_color = vec4(0.0);

uniform float bandRadius = 96.0;
uniform float bandStrength = 0.3;
uniform float lightRadius = 148.0;

float distance_to_light(vec2 coords) {
	float dist = 1000.0;

	for (int i = 0; i < numOfLights; i++) {
		float newDist = distance(coords, lights[i]);

		if (newDist < dist) {
			dist = newDist;
		}
	}
	return dist;
}

vec4 modulate(vec4 color, float distToLight) {
	vec4 modulated = color * modulateColor;

	if (distToLight > lightRadius) {
		return modulated;
	}

	if (distToLight >= bandRadius) {
		return mix(modulated, color, bandStrength);
	}
	return color;
}

void fragment() {
	COLOR = texture(screenTexture, SCREEN_UV);
	COLOR = modulate(COLOR, distance_to_light(FRAGCOORD.xy));
}
