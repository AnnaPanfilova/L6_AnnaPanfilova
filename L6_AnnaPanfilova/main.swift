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
        return elements.count > 0 ? elements.removeFirst() : nil
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

class Car: Colored {
    var brand: String
    var color: Color
    
    init(brand: String, color: Color) {
        self.brand = brand
        self.color = color
    }
    
    func printSelf() {
        print("brand: \(brand), color: \(color)")
    }
}

var carsQueue = Queue<Car>()

carsQueue.enqueue(Car(brand: "BMW", color: .red))
carsQueue.enqueue(Car(brand: "Mercedes", color: .blue))
carsQueue.enqueue(Car(brand: "Skoda", color: .green))
carsQueue.enqueue(Car(brand: "Lada", color: .red))

// Brush to purple all red cars
carsQueue.brushForColor(new: .purple) {
    $0 == .red
}

// Remove from queue all blue cars
carsQueue.cleanWithColor {
    $0 == .blue
}

print(carsQueue[0, 1]) // print colors for first and second car in queue
print(carsQueue[2, 10]) // print colors for third and tenth car in queue (returns nil)

// print cars form queue
while let car = carsQueue.dequeue() {
    car.printSelf()
}
