import UIKit

var datefomatter = DateFormatter()
datefomatter.dateFormat = "yyyy년 M월"

let dateString = datefomatter.string(from: Date())
print(dateString)

let string = "2023년 1월"
let date = datefomatter.date(from: string)
print(date as Any)
//print(datefomatter.string(from: date!))
