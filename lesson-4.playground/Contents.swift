import UIKit

/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */

enum SteeringPositions {
    case left, right
}

enum EngineTypes {
    case petrol, diesel, gas
}

enum ActionsWithCar {
    case startEngine
    case stopEngine
    
    case changeExhaustSound(TypesExhaustSounds)
    
    case putInTheTrunk(Int)
    case putOutTheTrunk(Int)
 }

enum EngineState {
     case launched, stopped
 }

enum TypesExhaustSounds {
    case type1, type2, type3
}

enum ExhaustSystemManufacturer {
    case Akrapovic
}

class Car {
    var brand: String
    var model: String
    var yearProduction: Int
    var mileage: Int
    var enginePower: Int
    var steeringPosition: SteeringPositions
    var engineType: EngineTypes
    var engineState: EngineState = .stopped {
        
        //  Заметил, что когда в deinit меняю engineState то willSet и didSet не выполяется
        
        willSet{
            print("У \(brand) \(model) будет изменен статус двигателя")
        }
        didSet {
            print("У \(brand) \(model) изменен статус двигателя на \(engineState)")
        }
    }
    
    init(brand: String, model: String, yearProduction: Int, mileage: Int, enginePower: Int, steeringPosition: SteeringPositions, engineType: EngineTypes) {
        
        self.brand = brand
        self.model = model
        self.yearProduction = yearProduction
        self.mileage = mileage
        self.enginePower = enginePower
        self.steeringPosition = steeringPosition
        self.engineType = engineType
    }
    
    deinit {
        self.engineState = .stopped
    }
    
    func performAction(action: ActionsWithCar) {}
    
    func printValues() {
             print("""
             ***
                Марка: \(self.brand)
                Модель: \(self.model)
                Год выпуска: \(self.yearProduction)
                Пробег: \(self.mileage)
                Статус двигателя: \(self.engineState)
                Мощность двигателя: \(self.enginePower)
                Расположение руля: \(self.steeringPosition)
                Тип двигателя: \(self.engineType)
             """)
         }
}

class SportСar: Car {
    
    var accelerationTo100KmInSec: Float
    var exhaustSystemManufacturer: ExhaustSystemManufacturer
    var typeExhaustSound: TypesExhaustSounds {
        didSet {
            print("У \(brand) \(model) изменен звук выхлопа на \(typeExhaustSound)")
        }
    }
    
    init(brand: String, model: String, yearProduction: Int, mileage: Int, enginePower: Int, steeringPosition: SteeringPositions, engineType: EngineTypes, accelerationTo100KmInSec: Float, exhaustSystemManufacturer: ExhaustSystemManufacturer, typeExhaustSound: TypesExhaustSounds) {
         
        self.accelerationTo100KmInSec = accelerationTo100KmInSec
        self.exhaustSystemManufacturer = exhaustSystemManufacturer
        self.typeExhaustSound = typeExhaustSound
        
        super.init(brand: brand, model: model, yearProduction: yearProduction, mileage: mileage, enginePower: enginePower, steeringPosition: steeringPosition, engineType: engineType)
    }
    
    override func performAction(action: ActionsWithCar) {
        
        switch action {
        case .startEngine:
            self.engineState = .launched
        case .stopEngine:
            self.engineState = .stopped
        case .changeExhaustSound(let typeSound):
            self.typeExhaustSound = typeSound
        default:
            print("Недопустимое действие: \(action)")
            
        }
        
    }
}

class TrunkCar: Car {
    
    var trunkVolume: Int
    var filledTrunkVolume: Int = 0
    
    init(brand: String, model: String, yearProduction: Int, mileage: Int, enginePower: Int, steeringPosition: SteeringPositions, engineType: EngineTypes, trunkVolume: Int) {
         
        self.trunkVolume = trunkVolume
        
        super.init(brand: brand, model: model, yearProduction: yearProduction, mileage: mileage, enginePower: enginePower, steeringPosition: steeringPosition, engineType: engineType)
    }
    
    override func performAction(action: ActionsWithCar) {
        
        switch action {
        case .startEngine:
            self.engineState = .launched
        case .stopEngine:
            self.engineState = .stopped
        case .putInTheTrunk(let volume):
            if volume + self.filledTrunkVolume <= self.trunkVolume {
                self.filledTrunkVolume = self.filledTrunkVolume + volume
                
            } else {
                print("В багажнике нет места. Вы можете поместить еще: \(self.filledTrunkVolume - self.trunkVolume)")
                
            }
        case .putOutTheTrunk(let volume):
            if filledTrunkVolume - volume >= 0 {
                self.filledTrunkVolume = self.filledTrunkVolume - volume
                
            } else {
                print("Вы хотите забрать из багажника то, чего нет. Вы можете забарть еще: \(self.filledTrunkVolume)")
                
            }
        default:
            print("Недопустимое действие: \(action)")
            
        }
    }
}

var porche = SportСar(brand: "Porche", model: "911 GT3 RS", yearProduction: 2020, mileage: 8, enginePower: 520, steeringPosition: .left, engineType: .petrol, accelerationTo100KmInSec: 3.2, exhaustSystemManufacturer: .Akrapovic, typeExhaustSound: .type1)

porche.performAction(action: .changeExhaustSound(.type3))
porche.performAction(action: .startEngine)

var mercedes: TrunkCar? = TrunkCar(brand: "Mercedes-Benz", model: "Arocs", yearProduction: 2019, mileage: 85000, enginePower: 450, steeringPosition: .left, engineType: .diesel, trunkVolume: 1024)

mercedes?.performAction(action: .startEngine)
mercedes?.performAction(action: .putInTheTrunk(512))

porche.printValues()
mercedes?.printValues()

mercedes = nil

