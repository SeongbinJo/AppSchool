
// Array
var treeArray1 = ["Pine", "Oak", "Apple"] // 리터럴 사용

var treeArray2: [String] = ["Pine", "Oak", "Apple"] // 타입 명시

var priceArray1 = [Float]() // 빈배열 생성
var priceArray2: [Float] = [] // 빈배열 생성

var nameArray1 = [String](repeating: "MyString", count: 10) // 디폴트 값 반복

let firstArray = ["red", "green", "blue"]
let secondArray = ["indigo", "violet"]

let thirdArray = firstArray + secondArray
print(thirdArray)// ["red", "green", "blue", "indigo", "violet"]
print(thirdArray.count) // 배열의 요소 개수 - 5
print(thirdArray.isEmpty) // 배열의 요소 유무 여부 - false
print(thirdArray[2]) // blue

treeArray1.shuffle() // 요소들의 위치 랜덤 변경
print(treeArray1)

print(treeArray1.randomElement() ?? "") // 요소 랜덤 뽑기 - 옵셔널

// 요소 추가
treeArray1[1] = "RedWood"
treeArray1.append("BlueWood") // treeArray1 += ["BlueWood"]
print(treeArray1) // ["Pine", "RedWood", "Apple", "BlueWood"]

// 요소 삽입
treeArray1.insert("Maple", at: 1)
print(treeArray1) // ["Pine", "Maple", "RedWood", "Apple", "BlueWood"]




// Dictionary
var bookDic: [String: String] = ["100-432112": "달빛 조각사", "100-123442": "나 혼자만 레벨업"]
var myDic: [Int: String] = [:]

let key = ["1", "2", "3", "4", "5"]
let value = ["Value1", "Value2", "Value3", "Value4", "Value5"]

let bookDict = Dictionary(uniqueKeysWithValues: zip(key, value)) // zip -> 요소 하나씩 맞물려서 매핑해줌.
//let bookDict = Dictionary(uniqueKeysWithValues: zip(1..., value))

print(bookDict)
print(bookDict.count) // 5
print(bookDict.keys) // ["4", "2", "5", "3", "1"]
print(bookDict.values) // ["Value4", "Value2", "Value5", "Value3", "Value1"]

for (key, value) in bookDic {
    print("Book Id : \(key), Value : \(value)")
}
// Book Id : 100-432112, Value : 달빛 조각사
// Book Id : 100-123442, Value : 나 혼자만 레벨업
