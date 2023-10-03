// BackBufferCopy copy method must be set to "Viewport"
// learned from:
// https://www.youtube.com/watch?v=Fb0MM4u5lWs
// https://github.com/mightymochi/Godot-3-Masking-Methods

shader_type canvas_item;

uniform bool invert_mask = false;

void fragment(){
	COLOR = texture(SCREEN_TEXTURE,SCREEN_UV);
	float alpha_total = texture(TEXTURE, UV).a;
	if (invert_mask == true) {
		alpha_total = 1.0 - alpha_total;
	}
	COLOR.a = alpha_total;
}