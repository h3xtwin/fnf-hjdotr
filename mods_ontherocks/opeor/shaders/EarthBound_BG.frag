#pragma header
uniform float iTime; // unused

// Layer 1
uniform float time1;
uniform vec2 amplitude1;
uniform vec2 frequency1;
uniform vec2 offset1;
uniform bool interweaved1 = false;
uniform float alpha1 = 1.0;

// Layer 2
uniform float time2;
uniform vec2 amplitude2;
uniform vec2 frequency2;
uniform vec2 offset2;
uniform bool interweaved2 = false;
uniform float alpha2 = 1.0;

uniform bool snesGridSnap = false; // 256x244 pixels

#define firstLayer bitmap
uniform sampler2D secondLayer;

#define snap(val, step) round(val * step) / step

const vec2 snesResolution = vec2(256, 244);

// Custom sampling function
vec4 flixel_texelFetch(sampler2D bitmap, ivec2 coord, int lod)
{
	vec4 color = texelFetch(bitmap, coord, lod);
	if (!(hasTransform || openfl_HasColorTransform))
		return color;
	
	if (color.a == 0.0)
		return vec4(0.0, 0.0, 0.0, 0.0);
	
	if (openfl_HasColorTransform || hasColorTransform)
	{
		color = vec4 (color.rgb / color.a, color.a);
		vec4 mult = vec4 (openfl_ColorMultiplierv.rgb, 1.0);
		color = clamp (openfl_ColorOffsetv + (color * mult), 0.0, 1.0);
		
		if (color.a == 0.0)
			return vec4 (0.0, 0.0, 0.0, 0.0);
		
		return vec4 (color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
	}	
	return color * openfl_Alphav;
}

void main(void)
{
    vec2 uv = openfl_TextureCoordv;//fragCoord / iResolution.xy;
    
    if(snesGridSnap) {
        uv = snap(uv, snesResolution);
    }
    
    // LAYER 1
    
    float waveFunX = time1 + uv.y * frequency1.x;
    float waveFunY = time1 + uv.y * frequency1.y;
    
    // Interwaving
    if(interweaved1 && int(uv.y * snesResolution.y) % 2 == 0) waveFunX *= -1.0;
    
    vec2 uvW = uv + offset1 + vec2(sin(waveFunX), sin(waveFunY)) * amplitude1;
    
    // Tiled
    vec2 layerSize1 = vec2(textureSize(firstLayer, 0));
    uvW = mod(uvW * layerSize1, layerSize1);
       
    vec4 layer1 = flixel_texelFetch(firstLayer, ivec2(uvW), 0); 
    
    
    // LAYER 2
    
    waveFunX = time2 + uv.y * frequency2.x;
    waveFunY = time2 + uv.y * frequency2.y;
    
    // Interwaving
    if(interweaved2 && int(uv.y * snesResolution.y) % 2 == 0) waveFunX *= -1.0;
    
    uvW = uv + offset2 + vec2(sin(waveFunX), sin(waveFunY)) * amplitude2;
    
    // Tiled
    vec2 layerSize2 = vec2(textureSize(secondLayer, 0));
    uvW = mod(uvW * layerSize2, layerSize2);
       
    vec3 layer2 = texelFetch(secondLayer, ivec2(uvW), 0);  
    
    // Output
    gl_FragColor = layer1 * alpha1 + vec4(layer2 * alpha2, 0.0);
}

// THANK YOU DREW ILY
