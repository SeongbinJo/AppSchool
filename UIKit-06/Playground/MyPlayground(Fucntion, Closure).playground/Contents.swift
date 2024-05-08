import UIKit

print("--------Function----------")
func serviceCharge() {
    let mealCost = 50
    let serviceCharge = mealCost / 10
    print("Service charge is \(serviceCharge)")
}
serviceCharge()


func serviceCharge(mealCost: Int) -> Int {
    return mealCost / 10
}
print(serviceCharge(mealCost: 50))


func serviceCharge(forMealPrice mealCost: Int) -> Int {
    return mealCost / 10
}
print(serviceCharge(forMealPrice: 50))


func calculateMonthlyPayments(carPrice: Double, downPayment: Double, interestRate: Double, paymentTerm: Double) -> Double {
    func loanAmount() -> Double {
        return carPrice - downPayment
    }
 
    func totalInterest() -> Double {
        return interestRate * paymentTerm
    }
    func numberOfMonths() -> Double {
        return paymentTerm * 12
    }
    return ((loanAmount() + (loanAmount() * totalInterest() / 100)) / numberOfMonths())
}
calculateMonthlyPayments(carPrice: 50000, downPayment: 5000, interestRate: 3.5, paymentTerm: 7)


// 함수를 반환하는 함수
func makePi() -> (() -> Double) {
    func generatePi() -> Double {
        return 22.0 / 7.0
    }
    return generatePi
}
let pi = makePi()
print(pi())


func isThereAMatch(listOfNumbers: [Int], condition: (Int) -> Bool) -> Bool {
    for item in listOfNumbers {
        if condition(item) {
            return true
        }
    }
    return false
}
func oddNumber(number: Int) -> Bool {
    return (number % 2) > 0
}
let numbersList = [2,4,6,7]
isThereAMatch(listOfNumbers: numbersList, condition: oddNumber)


func buySomething(itemValueEntered itemValueField: String, cardBalance: Int) -> Int {
    guard let itemValue = Int(itemValueField) else {
        print("error in item value")
        return cardBalance
    }
    let remainingBalance = cardBalance - itemValue
    return remainingBalance
}
print(buySomething(itemValueEntered: "10", cardBalance: 50))

print("--------------------------")


print("----------Closure----------")

var numbersArray = [2, 4, 6, 7]
let myClosure = { (number: Int) -> Int in
    let result = number * number
    return result
}
let mappedNumbers = numbersArray.map(myClosure)
let mappedNumbers2 = numbersArray.map({ (number: Int) -> Int in
    let result = number * number
    return result
})
let mappedNumbers3 = numbersArray.map({ number in
    number * number
})
let mappedNumber4 = numbersArray.map{ number in
    number * number
}
let mappedNumber5 = numbersArray.map{ $0 * $0 }

print("---------------------------")
