import UIKit

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */

enum EngineState {
    case launched, stopped
}

enum WindowsState {
     case opened, closed
}

enum CarModels {
    case Porche911GT3RS, MercedesBenzArocs
}

enum ActionsWithCar {
     case startEngine, stopEngine, openWindows, closeWindows, changeExhaustSound(TypesExhaustSoundsSportCar), putInTheTrunk(Int), putOutTheTrunk(Int)
}

protocol Car {
    var model: CarModels { get set }
    var yearProduction: Int { get set }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }
    
    func performAction(action: ActionsWithCar)
}

extension Car {
    
    mutating func startStopEngine() {
        switch self.engineState {
        case .launched:
            self.engineState = .stopped
        case .stopped:
            self.engineState = .launched
        }
    }
}

extension Car {
    
    mutating func openCloseWindows() {
        switch self.windowsState {
        case .closed:
            self.windowsState = .opened
        case .opened:
            self.windowsState = .closed
        }
    }
}

enum TypesExhaustSoundsSportCar {
     case type1, type2, type3
}

class SportCar: Car {
    
    var model: CarModels
    var yearProduction: Int
    var engineState: EngineState
    var windowsState: WindowsState
    var typeExhaustSound: TypesExhaustSoundsSportCar
    
    func performAction(action: ActionsWithCar) {
        switch action {
        case .changeExhaustSound(let type):
            self.typeExhaustSound = type
        // Хотел здесь для кейсов closeWindows и openWindows вызвать openCloseWindows(), которая в раширении протокола Car в итоге ошибка:
        // Cannot use mutating member on immutable value: 'self' is immutable
        // В расширении протокла Car в openCloseWindows() Xcode просит mutating
        default:
            print("Недопустимое действие: \(action)")
        }
    }
    
    init(model: CarModels, yearProduction: Int, typeExhaustSound: TypesExhaustSoundsSportCar){
    
        self.model = model
        self.yearProduction = yearProduction
        self.engineState = .stopped
        self.windowsState = .closed
        self.typeExhaustSound = typeExhaustSound
    }
}

class TrunkCar: Car {
    
    var model: CarModels
    var yearProduction: Int
    var engineState: EngineState
    var windowsState: WindowsState
    var trunkVolume: Int
    var filledTrunkVolume: Int

    
    func performAction(action: ActionsWithCar) {
        switch action {
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
    
    init(model: CarModels, yearProduction: Int, trunkVolume: Int){
    
        self.model = model
        self.yearProduction = yearProduction
        self.engineState = .stopped
        self.windowsState = .closed
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = 0
        
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        
        return """
                ***
                    Модель: \(self.model)
                    Год выпуска: \(self.yearProduction)
                    Статус двигателя: \(self.engineState)
                    Статус окон: \(self.windowsState)
                    Тип звука выхлопа: \(self.typeExhaustSound)
                """
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
                ***
                    Модель: \(self.model)
                    Год выпуска: \(self.yearProduction)
                    Статус двигателя: \(self.engineState)
                    Статус окон: \(self.windowsState)
                    Объем багажника: \(self.trunkVolume)
                    Заполненный объем багажника: \(self.filledTrunkVolume)
                """
    }
}

var sportCarPorche = SportCar(model: .Porche911GT3RS, yearProduction: 2020, typeExhaustSound: .type1)
sportCarPorche.performAction(action: .changeExhaustSound(.type3))
sportCarPorche.openCloseWindows()
sportCarPorche.startStopEngine()
print(sportCarPorche.description)

var trunkCarMB = TrunkCar(model: .MercedesBenzArocs, yearProduction: 2019, trunkVolume: 1024)
trunkCarMB.performAction(action: .putInTheTrunk(256))
trunkCarMB.startStopEngine()
print(sportCarPorche.description)

