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

struct Fries: CalorieCount {
    var calories: Int = 500
    
    func description() -> String {
        return "These fries has \(calories) calories"
    }
}

enum Sauce {
    case chili
    case tomato
    
    var calories: Int {
        switch self {
        case .chili:
            return 50
        case .tomato:
            return 80
        }
    }
    
    func description() -> String {
        switch self {
        case .chili:
            return "chili sauce has \(calories) calories"
        case .tomato:
            return "tomato sauce has \(calories) calories"
        }
    }
}

var fries = Fries(calories: 200)
fries.calories = 700
