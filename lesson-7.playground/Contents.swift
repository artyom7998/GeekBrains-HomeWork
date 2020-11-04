import UIKit

/*
1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
*/

enum EngineState {
    case launched, stopped
}

enum TransmissionShiftState {
    case P, R, N, D
}

enum AirbagsState {
    case ok, issue
}

enum HeadlightsState {
    case on, off
}

enum ActionsWithCar {
    case startEngine, stopEngine
}

enum StartCarError: Error {
    case alreadyLaunched
    case invalidTransmissionShiftState
    case lowBatteryLevel(level: Int)
    case airbagsIssue
    case headlightsIssue
}

class Car {
    
    var engineState: EngineState
    private var transmissionShiftState: TransmissionShiftState
    private var airbagsState: AirbagsState
    private var headlightsState: HeadlightsState
    private var batteryLevel: Int
    
    init() {
        self.engineState = .stopped
        self.transmissionShiftState = .P
        self.airbagsState = .ok
        self.headlightsState = .on
        self.batteryLevel = 100
    }
    
    func startEngineWithoutThrow() -> (Bool, StartCarError?) {
        
        guard self.engineState == .stopped else {
            return (false, .alreadyLaunched)
        }
        
        setRandomValue()
        
        guard self.batteryLevel > 30 else {
            return (false, .lowBatteryLevel(level: self.batteryLevel))
        }
        
        guard self.transmissionShiftState == .P else {
            return (false, .invalidTransmissionShiftState)
        }
        
        guard self.airbagsState == .ok else {
            return (false, .airbagsIssue)
        }
        
        guard self.headlightsState == .on else {
            return (false, .headlightsIssue)
        }
        
        self.engineState = .launched
        
        return(true, nil)
    }
    
    func performActionUseThrow(action: ActionsWithCar) throws {
        
        switch action {
        case .startEngine:
            return try startEngineUseThrow()
        case .stopEngine:
            self.engineState = .stopped
        }
    }
    
    private func startEngineUseThrow() throws {
        
        guard self.engineState == .stopped else {
            throw StartCarError.alreadyLaunched
        }
        
       setRandomValue()
        
        guard self.batteryLevel > 30 else {
            throw StartCarError.lowBatteryLevel(level: self.batteryLevel)
        }
        
        guard self.transmissionShiftState == .P else {
            throw StartCarError.invalidTransmissionShiftState
        }
        
        guard self.airbagsState == .ok else {
            throw StartCarError.airbagsIssue
        }
        
        guard self.headlightsState == .on else {
            throw StartCarError.headlightsIssue
        }
        
        self.engineState = .launched
        
    }
    
    private func setRandomValue() {
        self.batteryLevel = Int.random(in: 0...100)
        self.headlightsState = (Bool.random() ? .on : .off)
        self.airbagsState = (Bool.random() ? .ok : .issue)
        
        switch Int.random(in: 0...4) {
        case 0:
            self.transmissionShiftState = .P
        case 1:
            self.transmissionShiftState = .R
        case 2:
            self.transmissionShiftState = .N
        case 3:
            self.transmissionShiftState = .D
        default:
            self.transmissionShiftState = .P
        }
    }
}

var car1 = Car()

let startEngineDone = car1.startEngineWithoutThrow()

if startEngineDone.0 {
    print("Двигатель запущен")
} else if let error = startEngineDone.1 {
    print("Произошла ошибка при запуске двигателя: \(error)")
}

var car2 = Car()

do {
    try car2.performActionUseThrow(action: .startEngine)
    print("Двигатель запущен")
} catch StartCarError.airbagsIssue {
    print("Проблема с подушками безопасности")
} catch StartCarError.lowBatteryLevel(let level) {
    print("Низкий уровень заяряда аккумулятора: \(level)")
} catch StartCarError.alreadyLaunched {
    print("Двигатель уже запущен")
} catch StartCarError.headlightsIssue {
    print("Проблема с источниками освещения")
} catch StartCarError.invalidTransmissionShiftState {
    print("Неверный режим АКПП. Переведите в режим P")
} catch let error {
    print(error)
}
