//
//  Utilds.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/11/27.
//  Copyright © 2019 zhouyun. All rights reserved.
//


import RxSwift
import RxCocoa
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// Two way binding operator between control property and relay, that's all it takes.

infix operator <-> : DefaultPrecedence

#if os(iOS)
func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument

    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }

    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }

    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
        return text
    }

    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

func <-> <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.text)

    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            /**
             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
             The can be reproed easily if replace bottom code with
             
             if nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue ?? "")
             }

             and you hit "Done" button on keyboard.
             */
            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue)
            }
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
#endif

func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    if T.self == String.self {
#if DEBUG && !os(macOS)
        fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to relay.\n" +
            "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
            "REMEDY: Just use `textField <-> relay` instead of `textField.rx.text <-> relay`.\n" +
            "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
#endif
    }

    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}


//infix operator <-> : DefaultPrecedence
//
//
//func nonMarkedText(_ textInput: UITextInput) -> String? {
//    let start = textInput.beginningOfDocument
//    let end = textInput.endOfDocument
//
//    guard let rangeAll = textInput.textRange(from: start, to: end),
//        let text = textInput.text(in: rangeAll) else {
//            return nil
//    }
//
//    guard let markedTextRange = textInput.markedTextRange else {
//        return text
//    }
//
//    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start) ,
//        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
//            return text
//    }
//
//    return (textInput.text(in: startRange) ?? "") + ( textInput.text(in: endRange) ?? "")
//
//}
//
//func <-> <Base: UITextInput>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
//    let bindToUIDisposable = relay.bind(to: textInput.text)
//    let bindToVariable = textInput.text
//        .subscribe(onNext: { [weak base = textInput.base] n in
//            guard let base = base else {
//                return
//            }
//
//            let nonMarkedTextValue = nonMarkedText(base)
//
//            /**
//             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
//             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
//             The can be reproed easily if replace bottom code with
//
//             if nonMarkedTextValue != variable.value {
//             variable.value = nonMarkedTextValue ?? ""
//             }
//
//             and you hit "Done" button on keyboard.
//             */
//            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
//                relay.accept(nonMarkedTextValue)
//            }
//            }, onCompleted:  {
//                bindToUIDisposable.dispose()
//        })
//
//    return Disposables.create(bindToUIDisposable, bindToVariable)
//}
//
//func <-> <T>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
//    if T.self == String.self {
//        #if DEBUG
//            fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to variable.\n" +
//                "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
//                "REMEDY: Just use `textField <-> variable` instead of `textField.rx.text <-> variable`.\n" +
//                "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
//            )
//        #endif
//    }
//
//    let bindToUIDisposable = variable.asObservable()
//        .bind(to: property)
//    let bindToVariable = property
//        .subscribe(onNext: { n in
//            variable.accept(n)
//        }, onCompleted:  {
//            bindToUIDisposable.dispose()
//        })
//
//    return Disposables.create(bindToUIDisposable, bindToVariable)
//}
