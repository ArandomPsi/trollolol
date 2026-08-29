shader_type canvas_item;

uniform vec4 replace_color : source_color;

void fragment() {
    vec4 current_pixel = texture(TEXTURE, UV);
    // Keeps the sprite's original transparency, but swaps the RGB color
    COLOR = vec4(replace_color.rgb, current_pixel.a);
}
