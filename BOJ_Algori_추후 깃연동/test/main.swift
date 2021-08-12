//
//  main.swift
//  test
//
//  Created by inooph on 2021/08/12.
//

//let lineArr = line.split(separator: " ")
//let min = Int(lineArr[1])!
//print("Hello, World!")
import Foundation

//var n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))!
}

let x = arr[1]

print(readLine()!
        .split(separator: " ")
        .map{Int(String($0))!}
        .filter{ $0 < x }
        .map { "\($0)" }
        .joined(separator: " ")
)
