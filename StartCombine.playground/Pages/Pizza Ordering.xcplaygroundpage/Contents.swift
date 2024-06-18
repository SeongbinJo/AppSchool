import Foundation
import Combine

let pizzaOrder = Order()

// 1) didUpdateOrderStatus라는 피자집을 오픈!
let pizzaOrderPublisher = NotificationCenter.default.publisher(for: .didUpdateOrderStatus, object: pizzaOrder)

// 3) 28번줄의 didUpdateOrderStatus 피자집에 들어오는 순간 피자집에 알림이 가면서 sink, map 실행!
pizzaOrderPublisher.sink { notification in
    print(notification)
//    dump(notification)
}

pizzaOrderPublisher.map { notification in
    notification.userInfo?["status"] as? OrderStatus ?? OrderStatus.delivered
}
.sink { orderStatus in
    print("Order status [\(orderStatus)]")
}

// 4) 주문받은 값을 assign으로 담아냄!
pizzaOrderPublisher.compactMap { notification in
    notification.userInfo?["status"] as? OrderStatus
}
.assign(to: \.status, on: pizzaOrder)


// 2) didUpdateOrderStatus 라는 피자집에 들어가서, ["status": OrderStatus.processing]라는 주문을 넣을 예정!
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: pizzaOrder, userInfo: ["status": OrderStatus.processing])
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: pizzaOrder, userInfo: ["status": OrderStatus.delivered])

print("Order: \(pizzaOrder.status)")

