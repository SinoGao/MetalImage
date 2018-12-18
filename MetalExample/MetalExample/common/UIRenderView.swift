//
//  UIRenderView.swift
//  MetalExample
//
//  Created by gaobo01 on 2017/10/31.
//  Copyright © 2017年 gaobo01. All rights reserved.
//

import UIKit
import MetalKit
import QuartzCore
public class UIRenderView: UIView {
    var piple = PipleLine()
    let depthPixelFormat: MTLPixelFormat = .depth32Float
    let stencilPixelFormat: MTLPixelFormat = .invalid
    
    var metalLayer: CAMetalLayer! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    var commandQueue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        configMetal() 
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        metalLayer.frame = self.frame
    }
    
    func configMetal() {
        metalLayer = CAMetalLayer()
        metalLayer.device = piple.device
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.framebufferOnly = true
        
        //后续需要在其他地方修改Frame
        metalLayer.frame = self.frame
        layer.addSublayer(metalLayer)
        
        prepare()
    }
    
    func prepare() {
        let vertextProgram = piple.renderLibrary.makeFunction(name: "basic_vertex")
        let fragmentProgram = piple.renderLibrary.makeFunction(name: "basic_fragment")
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertextProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try pipelineState = piple.device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        }
        catch {
            print(error.localizedDescription)
        }
        
        commandQueue = piple.device.makeCommandQueue()
        timer = CADisplayLink(target: self, selector: #selector(drawloop))
        timer.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    @objc func drawloop() {
        self.render()
    }
    
    func render() {
        //clear
        let drawable = metalLayer.nextDrawable()
        let renderPassDesciptor = MTLRenderPassDescriptor()
        renderPassDesciptor.colorAttachments[0].texture = drawable?.texture
        renderPassDesciptor.colorAttachments[0].loadAction = .clear
        renderPassDesciptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0)
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDesciptor)
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.setVertexBuffer(piple.vertexBuffer, offset: 0, index: 0)
        renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6, instanceCount: 1)
        renderEncoder?.endEncoding()
        
        commandBuffer?.present(drawable!)
        commandBuffer?.commit()
    }
}
