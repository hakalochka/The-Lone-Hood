shader_type canvas_item;

uniform float whiteness : hint_range(0.0, 1.0) = 0.13;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec3 white = vec3(1.0);

    // Mix original color with white based on whiteness
    tex_color.rgb = mix(tex_color.rgb, white, whiteness);

    COLOR = tex_color;
}