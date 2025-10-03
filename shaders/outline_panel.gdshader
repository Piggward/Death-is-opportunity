
shader_type canvas_item;





// Center of the circle (UV space, 0–1)


uniform vec2 center = vec2(0.5, 0.5);


uniform vec3 fill_color = vec3(0.129, 0.604, 0.800);


// Radius of full transparency


uniform float radius : hint_range(0.0, 1.0) = 0.25;





// Width of the fade-out band


uniform float softness : hint_range(0.0, 1.0) = 0.4;





void fragment() {


    vec2 uv = UV;





    // Distance from pixel to circle center


    float dist = distance(uv, center);





    // Smooth transition: transparent at radius, opaque at radius+softness


    float alpha = smoothstep(radius, radius + softness, dist);





    // Texture color


    vec4 tex = texture(TEXTURE, uv);


	





    // Apply alpha fade


    COLOR = vec4(fill_color, tex.a * alpha);
}