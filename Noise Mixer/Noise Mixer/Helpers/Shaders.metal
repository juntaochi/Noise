//
//  File.metal
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28



#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[stitchable]] float2 wave(float2 position,float time,float speed, float frequency, float amplitude){
    float positionY = position.y + sin((time * speed) + (position.x / frequency)) * amplitude;
    return float2(position.x, positionY);
}
