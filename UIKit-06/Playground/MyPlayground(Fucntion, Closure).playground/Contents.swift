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




print("--------------------------")
