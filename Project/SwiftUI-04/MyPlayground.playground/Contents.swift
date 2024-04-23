import UIKit

var greeting = "Hello, playground"

//class 클래스 이름: 부모 클래스 {
//    // 프로퍼티
//    // let, var 정의
//    // 인스턴스 메서드
//    // 타입 메서드
//}

class BankAccount {
    // 프로퍼티
    var accountNumber: Int = 0
    var accountBalance: Float = 0
    let fees: Float = 25.00
    
    var balanceLessFees: Float {
        get {
            return accountBalance - fees
        }
        set (accountBalance) {
            self.accountBalance = accountBalance - fees
        }
    }
    
    lazy var myProperty: String = {
//        오래걸리는 작업
//        var result = resourceIntensiveTask()
//        result = processData(data: result)
//        return result
        return ""
    }()
    
    init() {
        accountNumber = 0
        accountBalance = 0
    }
    
    init(number: Int, balance: Float) {
        accountNumber = number
        accountBalance = balance
    }
    
    deinit {
        //필요한 정리작업을 수행
    }
    
    // 인스턴스 메서드
    func displayBalance() -> Void {
        print("Number \(accountNumber)")
        print("Current balance is \(accountBalance)")
    }
    
    // class 타입 메서드 상속 재정의 가능, static은 재정의 불가능
    class func getMaxBalance() -> Float {
        return 100000.00
    }
}

var bankAccount = BankAccount()

bankAccount.balanceLessFees = 12123.12

print(bankAccount.accountBalance)
print(bankAccount.accountNumber)
bankAccount.displayBalance()

print(BankAccount.getMaxBalance())


class SavingsAccount: BankAccount {
    var interestRate: Float = 0.0
    
    init(number: Int, balance: Float, rate: Float) {
        self.interestRate = rate
        super.init(number: number, balance: balance)
    }
    
    func calculateInterest() -> Float {
        return interestRate * accountBalance
    }
    
    override func displayBalance() {
        super.displayBalance()
        print("Prevailing interest reate is \(interestRate)")
    }
}

print("------------")
var savingAccount = SavingsAccount(number: 12311, balance: 600.00, rate: 0.07)

print(savingAccount.calculateInterest())
savingAccount.displayBalance()

extension Double {
    var squared: Double {
        return self * self
    }
    
    var cubed: Double {
        return self * self * self
    }
}


let myValue: Double = 3.0
print(myValue.squared)
