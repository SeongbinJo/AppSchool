import Foundation
import Combine

Just(42)
    .sink { value in // 전달받은 값으로 무언가 행동을 취한다. -> sink
        print("Received \(value)")
    }

["페퍼로니", "버섯", "양파", "치즈"].publisher // 값을 흘려보낸다. -> publisher
    .sink { topping in
        print("\(topping) is on my pizza.")
    }

"Combine".publisher // 문자열 자체를 흘려보내면 Char로 쪼개져 흐른다.
    .sink { value in
        print("\(value), Hello")
    }

Just("Combine") // 문자열을 Just를 사용해서 흘려보내면 문자열 덩어리가 흐른다.
    .sink { value in
        print("\(value), Hello")
    }

let num = 123
num.words.publisher
    .sink { value in
        print("\(value)") // 123
    }
num.description.publisher
    .sink { value in
        print("\(value)") // 1\n 2\n 3\n
    }
