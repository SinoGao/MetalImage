//
//  inputfragment.metal
//  MetalExample
//
//  Created by gaobo01 on 2017/10/31.
//  Copyright © 2017年 gaobo01. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
fragment half4 basic_fragment() {
    return half4(1.0, 0, 0, 1.0);
}
