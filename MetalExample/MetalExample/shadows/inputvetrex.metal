//
//  inputvetrex.metal
//  MetalExample
//
//  Created by gaobo01 on 2017/10/31.
//  Copyright © 2017年 gaobo01. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
vertex float4 basic_vertex (
                            constant packed_float3* vertex_array[[buffer(0)]],
                            unsigned int vid[[vertex_id]]) {
    return float4(vertex_array[vid], 1.0);
}
