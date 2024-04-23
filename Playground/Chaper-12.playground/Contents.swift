
// 구조체 정의
struct SampleStruct {
    var name: String
    
    // Struct(구조체)에서도 프로퍼티의 값을 초기화하기 위해선 생성자가 필요하다
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() {
        "Hello" + name
    }
}

// 클래스 정의
class SampleClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() {
        "Hello" + name
    }
}


let myStruct1 = SampleStruct(name: "Castle")
var myStruct2 = myStruct1
myStruct2.name = "콩"

// 구조체는 두번쨰만 바뀐다.
print(myStruct1.name)
print(myStruct2.name)

let myClass1 = SampleClass(name: "Castle")
var myClass2 = myClass1
myClass2.name = "콩"

// 클래스는 둘 다 바뀐다. 이유 - 클래스는 생성자에서 만들었을 때 myClass1의 주소값만 가지고있다. 이를 myClass2에 전달해준 것이다.(39번줄)
print(myClass1.name)
print(myClass2.name)



// 열거형 객체로 존재하기 때문에 프로퍼티를 담을 수 있게됨.
enum Temperature {
    case hot
    case warm
//    case cold
    case cold(temperature: Int)
}

func displayTemperature(temp: Temperature) {
    switch temp {
    case .hot:
        print("Hot!")
    case .warm:
        print("Warm!")
    case .cold:
        print("Cold!")
    case .cold(let temperature) where temperature <= 0:
        print("Ice warning : \(temperature) degrees.")
    }
}


displayTemperature(temp: .cold(temperature: -10)) // Cold!




