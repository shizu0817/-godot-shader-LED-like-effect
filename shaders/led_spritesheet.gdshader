shader_type canvas_item;
render_mode blend_add;

uniform vec4 color: source_color = vec4(vec3(0.0), 1.0);
uniform vec2 uv_scale = vec2(2.0);
uniform float led_size = 0.3;
uniform float smooth_interval = 0.2;
uniform float glow_above = 0.8;
uniform float glow_strength = 10.0;
uniform vec2 spritesheet_hv = vec2(1.0);


void fragment() {
	vec2 sprite_sheet_uv = fract(UV * spritesheet_hv);
	vec2 scaled_uv = sprite_sheet_uv * uv_scale;

	vec2 f_part = fract(scaled_uv);
	vec2 i_part = floor(scaled_uv);
	
	vec2 text_uv = (i_part+0.5) / uv_scale / spritesheet_hv + floor(UV * spritesheet_hv) / spritesheet_hv;
	vec4 text_color = texture(TEXTURE, text_uv);
	
	float distance_to_center = distance(f_part, vec2(0.5));
	float led_t = 1.0 - smoothstep(led_size, led_size + smooth_interval, distance_to_center);
	vec4 led_color = text_color * color;
	led_color.rgb = led_color.rgb + smoothstep(glow_above, 1.0, led_color.rgb) * glow_strength;

	vec4 out_color = mix(vec4(0.0,0.0,0.0,1.0), led_color, led_t);
	COLOR = out_color;
}
