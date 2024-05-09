import UIKit

// 프로토콜
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
}

//var fries = Fries(calories: 200)
//fries.calories = 700

//===============================


// 확장

extension Sauce: CalorieCount {
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

let burger = Burger()
let fries = Fries()
let sauce = Sauce.chili

let foodArray: [CalorieCount] = [burger, fries, sauce]

var totalCalories = 0
for food in foodArray {
    totalCalories += food.calories
}
print(totalCalories)

//===============================




// 에러 핸들링

enum WebsiteError: Error {
    case noInternetConnection
    case siteDown
    case wrongURL
}

func checkWebsite(siteUp: Bool) throws -> String {
    if siteUp == false {
        throw WebsiteError.siteDown
    }
    return "Site is up"
}

let siteStatus = true
do {
    print(try checkWebsite(siteUp: siteStatus))
}catch {
    print(error)
}

//===============================
