shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_never;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float pixel_size = 1.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 res = VIEWPORT_SIZE;

    uv = floor(uv * res / pixel_size) * pixel_size / res;

    ALBEDO = texture(screen_texture, uv).rgb;
}
