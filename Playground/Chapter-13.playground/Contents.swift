// 프로퍼티 래퍼
// 구조제의 함수가 길어졌을 때 구조체를 직접 수정하기 힘들어 생긴 -> 프로퍼티 래퍼

// 일반적인 구조체 정의
struct Address {
    private var cityname: String = ""
    
    
    var city: String {
        get { cityname } // cityname을 가져와서
        set { cityname = newValue.lowercased() } // cityname의 값을 변경한다. -> 소문자로 변경.
    }
}

var address = Address()
address.city = "Busan"
print(address.city) // busan

// 프로터피 래퍼 정의
@propertyWrapper
struct FixCase {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Contact {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
}

var contact = Contact(name: "Castle", city: "Busan", country: "South Korea")
print("\(contact.name), \(contact.city), \(contact.country)") // CASTLE, BUSAN, SOUTH KOREA


@propertyWrapper
struct MinMaxValue<V: Comparable> { // <> 제네릭, V : 대명사 -> 제네릭 V는 Comparable 프로토콜을 지켜야한다.
    var value: V
    var min: V
    var max: V
    
    init(wrappedValue: V, min: V, max: V) {
        value = wrappedValue
        self.min = min
        self.max = max
    }
    
    var wrappedValue: V {
        get { return value }
        set {
            if newValue > max {
                value = max
            }else if newValue < min {
                value = min
            }else {
                value = newValue
            }
        }
    }
}

struct Demo {
    @MinMaxValue(min: 10, max: 150) var value: Int = 100
    @MinMaxValue(min: "Apple", max: "Orange") var value2: String = "" // A - O 까지만 들어감.
}

var demo = Demo()

demo.value2 = "Banana" // B는 A - O 사이에 있기 때문에 Banana 출력
print(demo.value2) // Banana

demo.value2 = "Watermelon" // W는 A - O 사이에 없기 때문에 max값인 Orange 출력
print(demo.value2) // Orange
