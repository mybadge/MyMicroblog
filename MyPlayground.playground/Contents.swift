//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let a = (Double)(random() % 256) / 256.0

for i in 0...40 {
    //print((Double)(random() % 256) / 256.0)
}

//UIColor(red: (CGFloat)(random() % 256) / 256.0, green: (CGFloat)(random() % 256) / 256.0, blue: (CGFloat)(random() % 256) / 256.0, alpha: 1)


func gcd(var m: Int,var n: Int) -> Int{
    while (m != 0 && n != 0) {
        if m > n {
            m = m % n
            
        } else {
            n = n % m
            //print(n)
        }
        print("m=\(m) n=\(n)")
    }
    return m == 0 ? n : m
}

gcd(136, n: 22)