#version 330 core
out vec4 FragColor;

in vec2 TexCoord;
in vec3 Color;

uniform sampler2D texture1;

void main()
{
	FragColor = texture(texture1, TexCoord) * vec4(Color, 1.0f);
}