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
