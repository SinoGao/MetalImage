//
//  Pipleline.swift
//  MetalExample
//
//  Created by gaobo01 on 2017/10/31.
//  Copyright © 2017年 gaobo01. All rights reserved.
//
import Foundation
import MetalKit
public class MetalHelper {
    static let shared = MetalHelper()
    
    //设备驱动
    var device: MTLDevice! = nil
    
    //library 用来加载shadow
    var renderLibrary: MTLLibrary! = nil
    init() {
        device = MTLCreateSystemDefaultDevice()
        renderLibrary = device.makeDefaultLibrary()
    }
}
class PipleLine {

    //正方向顶点
    private let verticesData:[Float] = [
        -1.0, -1.0, 0.0,
        1.0, -1.0, 0.0,
        -1.0,  1.0, 0.0,

        1.0, -1.0, 0.0,
        -1.0,  1.0, 0.0,
        1.0,  1.0, 0.0,
        ]
    lazy var device: MTLDevice = {
        return MetalHelper.shared.device!
    }()
    lazy var renderLibrary: MTLLibrary = {
        return MetalHelper.shared.renderLibrary!
    }()

    //顶点缓冲区
    var vertexBuffer: MTLBuffer! = nil
    init() {
        let dataSize = verticesData.count * 4
        vertexBuffer = device.makeBuffer(bytes: verticesData, length: dataSize, options: MTLResourceOptions(rawValue: UInt(0)))
        vertexBuffer.label = "quad vertices"
    }
}

