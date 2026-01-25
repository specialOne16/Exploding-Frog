shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_always;

/* =======================
   TEXTURAS DE PANTALLA
   ======================= */
uniform sampler2D ScreenTexture : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DepthTexture  : hint_depth_texture,  filter_linear;

/* =======================
   TWIXEL / PIXELADO
   ======================= */
uniform float TwixelAngle : hint_range(0.0, 45.0) = 45.0;
uniform float PixelSize   : hint_range(1.0, 32.0) = 16.0;

/* =======================
   PALETA
   ======================= */
uniform bool Quantize = true;
uniform sampler2D PaletteTexture : source_color;

/* =======================
   FOG CON GRADIENTE
   ======================= */
uniform sampler2D FogGradient;
uniform float fog_strength : hint_range(0.0, 1.0) = 1.0;
uniform float fog_amount   : hint_range(0.0, 1.0) = 0.15;
uniform float fog_near = 1.0;
uniform float fog_far  = 300.0;

/* =======================
   VERTEX
   ======================= */
void vertex() {
    // Quad fullscreen
    POSITION = vec4(VERTEX.xy * 2.0, 1.0, 1.0);
}

/* =======================
   PALETA
   ======================= */
vec3 quantized_color(vec3 original_color) {
    ivec2 size = textureSize(PaletteTexture, 0);
    vec3 best = original_color;
    float min_dist = 9999.0;

    for (int y = 0; y < size.y; y++) {
        for (int x = 0; x < size.x; x++) {
            vec2 uv = (vec2(float(x), float(y)) + vec2(0.5)) / vec2(size);
            vec3 c = textureLod(PaletteTexture, uv, 0.0).rgb;
            float d = distance(original_color, c);
            if (d < min_dist) {
                min_dist = d;
                best = c;
            }
        }
    }
    return best;
}

/* =======================
   FRAGMENT
   ======================= */
void fragment() {
    vec2 frag_coord = FRAGCOORD.xy;
    vec2 pixel_size = 1.0 / VIEWPORT_SIZE;

    /* ----- ROTACIÓN TWIXEL ----- */
    float a = radians(TwixelAngle);
    mat2 rot = mat2(
        vec2(cos(a), -sin(a)),
        vec2(sin(a),  cos(a))
    );

    vec2 rotated = rot * frag_coord;
    vec2 pixelated = round(rotated / PixelSize) * PixelSize;
    vec2 final_coord = transpose(rot) * pixelated;

    final_coord = clamp(final_coord, vec2(1.0), VIEWPORT_SIZE - vec2(1.0));
    vec2 uv = final_coord * pixel_size;

    /* ----- COLOR BASE ----- */
    vec3 color = textureLod(ScreenTexture, uv, 0.0).rgb;

    if (Quantize) {
        color = quantized_color(color);
    }

    /* ----- PROFUNDIDAD LINEAL ----- */
    float depth = texture(DepthTexture, uv).x;
    vec4 clip = vec4(uv * 2.0 - 1.0, depth, 1.0);
    vec4 view = INV_PROJECTION_MATRIX * clip;
    view /= view.w;
    float linear_depth = -view.z;

    /* ----- FOG ----- */
    float fog_factor = clamp(
        (linear_depth - fog_near) / (fog_far - fog_near),
        0.0, 1.0
    );

    fog_factor *= fog_amount;

    vec4 fog = texture(FogGradient, vec2(fog_factor, 0.0));

    /* ----- RESULTADO FINAL ----- */
    vec3 final_color = mix(color, fog.rgb, fog.a * fog_strength);
    ALBEDO = final_color;
}
