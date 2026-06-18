shader_type canvas_item;

uniform sampler2D tex : source_color, hint_default_white, filter_nearest;

void fragment() {
	vec2 uv = vec2(UV.x,UV.y);
	
	uv.x+=(sin(uv.y*50.0 - (TIME*5.0))/200.0);
	
	uv = clamp(uv, vec2(0.0), vec2(1.0));
	vec4 texCol = texture(tex, uv);
	
	//ghost coloring
	texCol.b *= 1.5;
	texCol.r *= 0.6;
	texCol.g *= 1.2;
	
	COLOR = texCol;
}

