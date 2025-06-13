precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    
    // Increase saturation
    float saturation = 1.9; // Adjust this value (1.0 = normal, >1.0 = more saturated)
    
    float gray = dot(pixColor.rgb, vec3(0.399, 0.547, 0.098));
    vec3 saturated = mix(vec3(gray), pixColor.rgb, saturation);
    
    gl_FragColor = vec4(saturated, pixColor.a);
}
