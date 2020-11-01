import UIKit

/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

struct Queue<T: UserPayment> {
    private var elements: [T] = []
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        return elements.removeFirst()
    }
    
    func filter(predicate: (UserPayment) -> Bool ) -> [Int] {
        
        var tempIndices = [Int]()
        
        for (index, value) in elements.enumerated() {
            if predicate(value) {
                tempIndices.append(index)
            }
        }
        return tempIndices
        
    }
    
    func recurringUserId() ->  Dictionary<String, Any> {
        let crossReference = Dictionary(grouping:  self.elements, by: { $0.userId })
        let duplicates = crossReference.filter { $1.count > 1 }
        return duplicates
    }
    
    subscript(index: Int) -> UserPayment? {
        
        if index < self.elements.count {
            return self.elements[index]
        } else {
            return nil
        }
    }
}

protocol Payment {
    var userId: String { get set }
    var paymentAmount: Int { get set }
}

class UserPayment: Payment {
    var userId: String
    var paymentAmount: Int
    
    init(userId: String, paymentAmount: Int ) {
        self.userId = userId
        self.paymentAmount = paymentAmount
    }
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

var queue = Queue<UserPayment>()
var arrayPaymentAmounts = Array(10000...10200)

arrayPaymentAmounts.forEach { (paymentAmount) in
    let userId = randomString(length: 1)
    queue.push(UserPayment(userId: userId, paymentAmount: paymentAmount))
}

let nonUniquePayments = queue.recurringUserId()
var uniquePaymentsIndices = queue.filter { (UserPayment) -> Bool in
    return nonUniquePayments[UserPayment.userId] == nil
}

var printText = "Уникальные платежи: \n"
uniquePaymentsIndices.forEach {
    let payment = queue[$0]
    printText += "ИД: \(String(describing: payment!.userId)), сумма: \(String(describing: payment!.paymentAmount)) \n"
}
print(printText)
