//
//  ElectricCarModel.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

class ElectricCar: Car, Electric {
    var electricEfficiency: Double
    var fullChargeHours: Double
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, electricEfficiency: Double, fullChargeHours: Double, autoLevel: Int) {
        self.electricEfficiency = electricEfficiency
        self.fullChargeHours = fullChargeHours
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
    
    override func getDetail() -> String {
        return super.getDetail() + "ElectricEfficiency: \(electricEfficiency), ChargeHour: \(fullChargeHours), AutoLevel: \(autoLevel)"
    }
}
