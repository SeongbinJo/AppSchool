//
//  CarProtocol.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

protocol Fuel {
    var fuelEfficiency: Double {
        get set
    }
    
    var isGasoline: Bool {
        get set
    }
    
    var isAutomatic: Bool {
        get set
    }
    
    var fuelEfficiencyString: String { get }
    var isGasolineString: String { get }
    var isAutomaticString: String { get }
}

extension Fuel {
    var fuelEfficiencyString: String {
        String(format: "%.2f", fuelEfficiency)
    }
    
    var isGasolineString: String {
        isGasoline ? "가솔린" : "디젤"
    }
    
    var isAutomaticString: String {
        isAutomatic ? "자동변속" : "수동변속"
    }
}



protocol Electric {
    var electricEfficiency: Double {
        get set
    }

    var fullChargeHours: Double {
        get set
    }
    
    var autoLevel: Int {
        get set
    }
    
    var electricEfficiencyString: String { get }
    var fullChargeHoursString: String { get }
    var autoLevelHoursString: String { get }
}

extension Electric {
    var electricEfficiencyString: String {
        String(format: "%.2f", electricEfficiency)
    }
    var fullChargeHoursString: String {
        String(format: "%.2f", fullChargeHours)
    }
    var autoLevelHoursString: String {
        String(format: "%.2f", autoLevel)
    }
}


protocol CarDescriptionProtocol {
    var brand: String { get }
    var modelName: String { get }
    var year: Int { get }
    
    // 프로토콜 안에서는 내용을 구현할 수 없다!
    func getDetail() -> String
}

// 프로토콜 안에서 내용을 구현할 수 없기 때문에 extension으로 내용을 구현해준다!
extension CarDescriptionProtocol {

}
