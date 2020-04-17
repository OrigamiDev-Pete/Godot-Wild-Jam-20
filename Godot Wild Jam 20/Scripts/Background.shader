shader_type canvas_item;

uniform vec4 colour : hint_color;

void fragment() {
	vec3 col = colour.rbg * (sin(TIME) * 0.3 + 1.5);
	COLOR.rbg = col;
}