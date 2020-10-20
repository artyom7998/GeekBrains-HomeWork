import UIKit

/*
1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
2. Описать в каждом наследнике специфичные для него свойства.Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль.
*/

struct SportCar {
    
    var brand: String
    var model: String
    var yearProduction: Int
    var engineState: EngineState
    var windowsSate: WindowsState
    var bodyVolume: Int
    var filledBodyVolume: Int
    
    init(brand: String, model: String, yearProduction: Int, bodyVolume: Int) {
        self.brand = brand
        self.model = model
        self.yearProduction = yearProduction
        self.bodyVolume = bodyVolume
        self.engineState = .stopped
        self.windowsSate = .closed
        self.filledBodyVolume = 0
    }
    
    func printPropertyValues() {
        print("""
        ***
            Марка: \(self.brand)
            Модель: \(self.model)
            Год выпуска: \(self.yearProduction)
            Статус двигателя: \(self.engineState.rawValue)
            Статус окон: \(self.windowsSate.rawValue)
            Объем багажника: \(self.bodyVolume)
            Заполненный объем багажника: \(self.filledBodyVolume)
        """)
    }
    
    mutating func performAction(action: ActionsWithAuto) {
        
        switch action {
        case .startEngine:
            self.engineState = .launched
        case .stopEngine:
            self.engineState = .stopped
        case .openWindows:
            self.windowsSate = .opened
        case .closeWindows:
            self.windowsSate = .closed
        case .putInTheBody(let volume):
            if volume + self.filledBodyVolume <= self.bodyVolume {
                self.filledBodyVolume = self.filledBodyVolume + volume
            } else {
                print("В багажнике нет места. Вы можете поместить еще: \(self.filledBodyVolume - self.bodyVolume)")
            }
        case .putOutTheBody(let volume):
            if filledBodyVolume - volume >= 0 {
                self.filledBodyVolume = self.filledBodyVolume - volume
            } else {
                print("Вы хотите забрать из багажника то, чего нет. Вы можете забарть еще: \(self.filledBodyVolume)")
            }
        default:
            print("Недопустимое действие: \(action)")
        }
    }
    
}

struct TrunkCar {
    
    var brand: String
    var yearProduction: Int
    var engineState: EngineState
    var windowsSate: WindowsState
    var trunkVolume: Int
    var filledTrunkVolume: Int
    
    init() {
        
        self.brand = "КамАЗ"
        self.yearProduction = 2019
        self.engineState = .stopped
        self.windowsSate = .closed
        self.trunkVolume = 10300
        self.filledTrunkVolume = 0
        
    }
    
    mutating func performAction(action: ActionsWithAuto) {
        
        switch action {
        case .startEngine:
            self.engineState = .launched
        case .stopEngine:
            self.engineState = .stopped
        case .openWindows:
            self.windowsSate = .opened
        case .closeWindows:
            self.windowsSate = .closed
        case .putInTheTrunk(let volume):
            if volume + self.filledTrunkVolume <= self.trunkVolume {
                self.filledTrunkVolume = self.filledTrunkVolume + volume
            } else {
                print("В кузове нет места. Вы можете поместить еще: \(self.filledTrunkVolume - self.trunkVolume)")
            }
        case .putOutTheTrunk(let volume):
            if filledTrunkVolume - volume >= 0 {
                self.filledTrunkVolume = self.filledTrunkVolume - volume
            } else {
                print("Вы хотите забрать из кузова то, чего нет. Вы можете забарть еще: \(self.filledTrunkVolume)")
            }
        default:
            print("Недопустимое действие: \(action)")
        }
    }
    
    func printPropertyValues() {
        print("""
        ***
            Марка: \(self.brand)
            Год выпуска: \(self.yearProduction)
            Статус двигателя: \(self.engineState.rawValue)
            Статус окон: \(self.windowsSate.rawValue)
            Объем кузова: \(self.trunkVolume)
            Заполненный объем кузова: \(self.filledTrunkVolume)
        """)
    }
    
}

enum EngineState: String {
    case launched = "запущен"
    case stopped  = "остановлен"
}

enum WindowsState: String {
    case opened = "открыты"
    case closed = "закрыты"
}

enum ActionsWithAuto {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case putInTheTrunk(Int)
    case putOutTheTrunk(Int)
    case putInTheBody(Int)
    case putOutTheBody(Int)
}

var carNissan = SportCar.init(brand: "Nissan", model: "Teana", yearProduction: 2011, bodyVolume: 488)
carNissan.performAction(action: .putInTheBody(128))
carNissan.performAction(action: .putInTheBody(256))
carNissan.performAction(action: .putOutTheBody(512))

var carLamborghini = SportCar.init(brand: "Lamborghini", model: "Huracan", yearProduction: 2020, bodyVolume: 0)
carLamborghini.performAction(action: .startEngine)
carLamborghini.performAction(action: .openWindows)

var trunkCar = TrunkCar()
trunkCar.performAction(action: .startEngine)
trunkCar.performAction(action: .putInTheTrunk(1024))

carNissan.printPropertyValues()
carLamborghini.printPropertyValues()
trunkCar.printPropertyValues()

