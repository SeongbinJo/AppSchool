import UIKit

protocol CalorieCount {
    var calories: Int { get }
    func description() -> String
}

class Burger: CalorieCount {
    var calories: Int = 800
    
    func description() -> String {
        return "This burger has \(calories) calories"
    }
    
    
}

class Fries: CalorieCount {
    var calories: Int = 500
    
    func description() -> String {
        return "These fries has \(calories) calories"
    }
}

enum Sauce {
    case chili
    case tomato
}


