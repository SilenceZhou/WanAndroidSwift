//
//  RxSwiftViewController.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/27.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit

class RxSwiftViewController: UIViewController {
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    let text = BehaviorRelay(value: "双向绑定")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testMapFilter()
        
        
        // 自定义前缀
        UIView()
            .zy.color(UIColor.red)
            .zy.frame(CGRect(x: 100, y: 250, width: 100, height: 100))
            .zy.addTo(superView: view)
            .zy.tap(target: self, action: #selector(tap(_:)))
        
        return
            
        
        
        /// 1.双向绑定 VM 和 UI 
        /// 2.用来做一个临时变量处理 后续操作
        _  = textFiled.rx.textInput <-> text
        
//        let textFiledValid = textFiled.rx.text.
        let textFiledValid = textFiled.rx.text.orEmpty.map { (string) -> Bool in
            return string.count > 10
        }
        
        
        // Binder 不会处理错误事件 ； 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
        // ... : 可以防止多个  Binder
        textFiledValid
            .bind(to: label.rx.isHidden, label.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        
        textFiled.rx.text
            .asObservable()
            .subscribe{
                // 这个不是监听 textFiled的text变化的打印么？
                // 为什么直接赋值不打印呢
                print("textfield: \($0)")
        }
        .disposed(by: disposeBag)

        textFiled.text = "这是我修改的值"
        textFiled.sendActions(for: .editingChanged)
        
        
        text.asObservable().subscribe(onNext: { string in
            
            print("2222 = \(string)")
            
            }).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        text.accept("哈哈 touch begin")
    }
    
    
    /// 双向绑定： UI 和 VM 绑定 互相通讯
    /// 参考链接：
    /// 比较系统 https://www.hangge.com/blog/cache/detail_1974.html
    /// 没说明白 http://www.alonemonkey.com/2017/04/01/rxswift-part-ten/
    /// 参考官方Demo
    
    func testTwoWayBinding() {
        
        //  var textOberservale: BehaviorRelay<String>?

        let textOberservale = BehaviorRelay(value:"终老")
        
        // textOberservale = BehaviorRelay(value:"终老")
        _ = textFiled.rx.textInput <-> textOberservale
        
        
        textFiled.rx.text
            .asObservable()
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
        
        textFiled.rx.text
            .map{ "输入:\($0 ?? "")" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //        let textInput = textFiled.rx.text.orEmpty.asDriver().throttle(0.5)
        //        textInput.map { "输入：\($0)" }
        //            .drive(label.rx.text)
        //            .disposed(by: disposeBag)
        
        textOberservale.accept("heheh")
    }
    
    let disposeBag = DisposeBag()
    
    
    @objc private func tap(_ gesture: UITapGestureRecognizer) {
        print("打印")
    }
    
    func testReduce()  {
    
     let result =   [1,2,3,4].reduce(10) { (x, y) -> Int in
        // x 的值
        // 第一次： 为initialResult的值
        // 第a...n ： 为上一次的计算后的结果值
            print(x, y)
            return x - y
        }
        
        print("result = \(result)")
        
    }
    
    func testMapFilter() {
        
       let arr = (1..<10).map{$0*$0}.filter{ val in
            return val % 2 == 0
        }// [4, 16, 36, 64]
        
        print("arr = \(arr)")
    }



}
