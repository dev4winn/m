
attribute vec4 a_position;
attribute vec2 a_texCoord;

uniform vec2 resolution;
varying vec2 texCoordV;

void main()
{
    gl_Position = CC_PMatrix * a_position;
    texCoordV = a_texCoord;
}