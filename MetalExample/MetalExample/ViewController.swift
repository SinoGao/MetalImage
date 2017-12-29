//
//  ViewController.swift
//  MetalExample
//
//  Created by gaobo01 on 2017/10/31.
//  Copyright © 2017年 gaobo01. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    var metalView: UIRenderView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        build()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func build() {
        metalView = UIRenderView()
        metalView.backgroundColor = UIColor.black
        view.addSubview(metalView)
        metalView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
}

