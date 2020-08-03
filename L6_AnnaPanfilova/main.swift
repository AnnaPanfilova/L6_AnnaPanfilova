//
//  main.swift
//  L6_AnnaPanfilova
//
//  Created by Anna on 03.08.2020.
//  Copyright © 2020 Anna. All rights reserved.
//

import Foundation

enum Color {
    case red, orabge, yellow, green, blue, purple
}

protocol Colored {
    var color: Color { get set }
}

struct Queue<T: Colored> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return elements.removeFirst()
    }
    
    /**
     Brush elements with new color if term closure returns true
     */
    mutating func brushForColor(new color: Color, term: (_ old: Color) -> Bool) {
        for i in 0..<elements.count {
            if term(elements[i].color) {
                elements[i].color = color
            }
        }
    }
    
    /**
    Remove lements if term closure returns true
    */
    mutating func cleanWithColor(term: (_: Color) -> Bool) {
        var i = 0
        while i < elements.count {
            if term(elements[i].color) {
                elements.remove(at: i)
            } else {
                i += 1
            }
        }
    }
    
    /**
     Returns array with unique colors of queue's elements
     */
    subscript(indices: UInt ...) -> [Color]? {
        var colors: [Color] = []
        
        for index in indices {
            if index < elements.count {
                let elementColor = elements[Int(index)].color
                if !colors.contains(elementColor) {
                    colors.append(elementColor)
                }
            } else {
                return nil
            }
        }
        
        return colors
    }

}
