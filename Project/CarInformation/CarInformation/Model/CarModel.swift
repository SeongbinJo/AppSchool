//
//  CarModel.swift
//  CarInformation
//
//  Created by 조성빈 on 4/16/24.
//

import Foundation

class Car: Identifiable, CarDescriptionProtocol {
    let id = UUID()
    var brand: String
    var modelName: String
    var year: Int
    var doorCount: Int
    var weight: Double
    var height: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double) {
        self.brand = brand
        self.modelName = modelName
        self.year = year
        self.doorCount = doorCount
        self.weight = weight
        self.height = height
    }
    
    func getDetail() -> String {
        return "Brand: \(brand), Model: \(modelName), Year: \(year)"
    }
}

class OilCar: Car, Fuel {
    var isAutomatic: Bool
    var fuelEfficiency: Double
    var isGasoline: Bool
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, isAutomatic: Bool, fuelEfficiency: Double, isGasoline: Bool) {
        self.isAutomatic = isAutomatic
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
    
    override func getDetail() -> String {
        return super.getDetail() + "Automatic: \(isAutomatic), FuelEfficiency: \(fuelEfficiency), Gasoline: \(isGasoline)"
    }
}

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
