import UIKit

enum TrafficLightColor: String {
    case red
    case yellow
    case green
    func description() -> String {
        switch self {
        case .red:
            return "red"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        }
    }
}

var trafficLightColor = TrafficLightColor.red
print(trafficLightColor.description())
print(trafficLightColor.rawValue)
