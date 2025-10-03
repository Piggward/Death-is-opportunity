shader_type canvas_item;

uniform vec3 fill_color = vec3(0.129, 0.674, 0.8);
uniform float outline_size : hint_range(0.0, 10.0) = 2.0;      // pixels

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Only draw outline on transparent pixels
    if (tex.a == 0.0) {
        float alpha = 0.0;
        float px = outline_size / TEXTURE_PIXEL_SIZE.x;
        float py = outline_size / TEXTURE_PIXEL_SIZE.y;

        alpha += texture(TEXTURE, UV + vec2(-px, 0.0)).a;
        alpha += texture(TEXTURE, UV + vec2(px, 0.0)).a;
        alpha += texture(TEXTURE, UV + vec2(0.0, -py)).a;
        alpha += texture(TEXTURE, UV + vec2(0.0, py)).a;

        alpha = clamp(alpha, 0.0, 1.0);
        COLOR = vec4(fill_color, alpha);
    } else {
        COLOR = tex;
    }
}
