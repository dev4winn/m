
//precision mediump float;
//uniform sampler2D texture0;
uniform float amount;
//uniform float time;
uniform vec3 drops[2]; // x,y are pos z is age
uniform float aspect;
varying vec2 texCoordV;

vec2 offset;
float dist;
float wave;
vec2 surf;
vec2 dir;
vec2 txC;
float w;
float cau;

void main()
{
    txC = texCoordV * vec2(1.0, aspect);
    cau = distance(vec2(-1.0, -1.0), txC) * 20.0 + CC_CosTime[3];
    surf = vec2(sin(cau), cos(cau)) * 0.01;
    cau = distance(vec2(1.0, 1.0), txC) * 30.0 + CC_SinTime[3];
    surf += vec2(sin(cau), cos(cau)) * 0.02;
    for(int i = 0; i < 2; i+= 1){
        if(drops[i].z > -90.0)
        {
            dir = drops[i].xy - txC;
            dist = length(dir);
            dir = normalize(dir);
            w = cos((4.0 / (1.0 + pow(2.0, dist * 50.0 - drops[i].z))) * 6.283185) * -0.5 + 0.5;
            wave = w * pow(2.0, -dist * 8.0);
            surf += dir * wave;
        }
    }
    offset = texCoordV + surf * amount;
    //vec3 tx = vec3(texCoordV, 0.0);
    //vec3 norm = normalize(vec3(surf, 1.0));
    //vec3 toLight = normalize(vec3(0.0, -0.0, 0.0) - tx);
    //vec3 toCamera = normalize(vec3(0.0, 0.0, 1.0) - tx);
    //vec3 lRef = normalize(2.0 * dot(norm, toLight) * norm - toLight);
    //float spec = dot(lRef, toCamera) * 2.0;
    //spec = clamp(spec, 0.0, 1.3) - 0.6;
    //spec = pow(spec, 8.0) * 4.0;

    vec4 col = texture2D(CC_Texture0, offset);
    //col.xyz = col.xyz + spec;
    gl_FragColor = col;
}