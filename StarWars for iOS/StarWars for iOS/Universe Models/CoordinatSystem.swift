//
//  PointGenerator.swift
//  StarWars
//
//  Created by Aleksey Rochev (Netology) on 19.11.2019.
//  Copyright © 2019 Aleksey Rochev (Netology). All rights reserved.
//

import UIKit

typealias Point = CGPoint
typealias Rect = CGRect

extension Point {
    static func generate() -> Point {
        let x = Int.random(in: 0...10)
        let y = Int.random(in: 0...10)
        return Point(x: x, y: y)
    }
}

extension Point {
    static func distance(from: Point, to: Point) -> Double {
        return sqrt(pow(Double(to.x-from.x), 2.0)+pow(Double(to.y-from.y), 2.0))
    }
}

extension Rect {
    static func generate() -> Rect {
        let x = Int.random(in: 0...10)
        let y = Int.random(in: 0...10)
        return Rect(x: x, y: y, width: 2, height: 2)
    }
}
