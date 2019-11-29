import UIKit


// 柯里化类似于工厂方法



// 1. 普通方法
func add(_ a: Int, _ b: Int) -> Int { a + b }
let result = add(2, 3)


// 2. 函数式方法
func add(_ a: Int) -> (Int) -> Int {
    print(a)
    return { b in
        print(b)
       return a + b
    }
}

let add2 = add(2)
add2(10)



func addThree(_ a: Int) -> (Int) -> ( (Int) -> Int ) {
    
    print("a = \(a)")
    
    return { v1 in
        print("v1 = \(v1)")
        return { v2 in
            print("v2 = \(v2)")
            return v1 + v2 + a
        }
    }
}

let addThreeFunc = addThree(10)(20)(30)


// 3.柯里化 （普通函数 通过 柯里化 转换为 函数式方法）
// 3.1. 两个参数相加
func currying<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    return { b in
        print("2222 b = \(b)")
        return { a in
            print("2222 a = \(a)")
            return fn(a, b)
        }
        
    }
}

currying(add)(10)(20)



// 3.2. 两个参数相加
// 读数 从左到右
func add(_ a: Int, _ b: Int, _ c: Int) -> Int {
    
    print("a = \(a)")
    print("b = \(b)")
    print("c = \(c)")
    return a + b + c
}
//add(30, 20, 10)

// 读数 从右到左
func currying2<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
    return { c in
        print("333 c = \(c)")
        return { b in
            print("222 b = \(b)")
            return { a in
                print("111 a = \(a)")
                return fn(a, b, c)
            }
        }
        
    }
}


currying2(add)(10)(20)(30)


/// 合并多个方法 操作符




 

