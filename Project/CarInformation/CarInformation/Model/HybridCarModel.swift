//
//  HybridCarmodel.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

class HybridCar: Car, Fuel, Electric {
    var isAutomatic: Bool = false
    var electricEfficiency: Double = 0.0
    var fullChargeHours: Double = 0.0
    var fuelEfficiency: Double
    var isGasoline: Bool
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, fuelEfficiency: Double, isGasoline: Bool, autoLevel: Int) {
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
    
    override func getDetail() -> String {
        return super.getDetail() + "Automatic: \(isAutomatic), FuelEfficiency: \(fuelEfficiency), Gasoline: \(isGasoline)"
    }
}
