import UIKit

class Animal {
    var name: String
    var sound: String
    var numberOfLegs: Int
    var breathesOxygen: Bool = true
    
    init(name: String, sound: String, numberOfLegs: Int, breathesOxygen: Bool) {
        self.name = name
        self.sound = sound
        self.numberOfLegs = numberOfLegs
        self.breathesOxygen = breathesOxygen
    }
    
    func makeSound() {
        print(self.sound)
    }
    
    func description() -> String {
        return "name: \(name), \nsound: \(sound), \nnumberOfLegs: \(numberOfLegs), \nbreathesOxygen: \(breathesOxygen)"
    }
}

class Mammal: Animal {
    let hasFurOrHair: Bool = true
}

let cat = Mammal(name: "Cat", sound: "Mew", numberOfLegs: 4, breathesOxygen: true)
print(cat.description())
