/*
	Sets aspect ratio of 1:1
	Sets origin at center of screen

	X is in [-aspect,aspect], where aspect = iResolution.x / iResolution.y
	Y is in [-1,1]
*/
void change_coordinate_space(inout vec2 xy)
{
    // Move origin to center of screen
    xy -= 0.5 * iResolution.xy;
		// Make aspect ratio = 1
    xy /= iResolution.y;
    // Stretches the space to [-1,1] at Y
    xy *= 2.0;
}

/*
	Indicates how much "inside a circle" is a given point
 	p = given point
 	c = center of the circle
 	r = radius of the circle
*/
float circle_insideness(vec2 p, float c, float r)
{
    float tolerance = 0.0075;
    return smoothstep(r + tolerance, r - tolerance, length(c-p));
}

void mainImage(out vec4 fragColor, vec2 pixel)
{
    // Centers the origin, adjusts aspect ratio
    change_coordinate_space(pixel);

    // Background color: rainbow
    vec3 bgc = vec3((pixel.y+1.0)/2.0,0.5+0.5*cos(iGlobalTime),0.5+0.5*sin(iGlobalTime));

    // Circle color: red
    vec3 red = vec3(1,0,0);

    // Pixel color: red if inside the circle, rainbow otherwise
    vec3 ret = mix(bgc, red, circle_insideness(pixel, 0.0, 0.5));

    // Returns color
    fragColor = vec4(ret,1.0);
}
