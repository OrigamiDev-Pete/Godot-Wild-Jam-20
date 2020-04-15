shader_type canvas_item;

uniform sampler2D palette;


void fragment() {
	// get colour values from the sprite
	vec4 mask_colour = texture(TEXTURE, UV);
	vec4 output;
	
	highp float color_r = mask_colour.r;
	output = texture(palette, vec2(color_r, 0.0));
	
	COLOR.rbg = output.rbg;
	COLOR.a = mask_colour.a;
}