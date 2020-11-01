import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.
func evenNumber(_ number:Int) -> Bool {
    return number % 2 == 0
}

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func divBy3WoRemainder(_ number:Int) -> Bool {
    return number % 3 == 0
}

// 3. Создать возрастающий массив из 100 чисел.
func getAscendingArrayNumbers(_ countNumbers:Int = 100) -> [Int] {
    
   // var array:Array<Int>
    var array = [Int]()

    for i in 0..<countNumbers {
        array.append(i)
    }
    
    return array
}

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

var array = getAscendingArrayNumbers().filter { (element) in
    divBy3WoRemainder(element) && evenNumber(element)
    
    // Вопрос. Возможно ли в метод filter передача нескольких условий более кратко? Хотел вот так сделать: filter(evenNumber && divBy3WoRemainder)
}

// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
func addNewFibonacciNumberToArray(_ array: inout Array<Double>) {
    
    let arrayCount = array.count
    
    if arrayCount == 0 {
        array.append(0)
    } else if arrayCount == 1 {
        array.append(1)
    } else if arrayCount > 1 {
        array.append(array[arrayCount-1] + array[arrayCount-2])
    }
    
}

var arrayFibonacciNumbers = [Double]()
var i = 0

while i < 100 {
    i += 1
    addNewFibonacciNumberToArray(&arrayFibonacciNumbers)
}

/* 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:

    a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
    b. Пусть переменная p изначально равна двум — первому простому числу.
    c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
    d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
    e. Повторять шаги c и d, пока возможно.
*/

var arrayPrimeNumbers = [Int]()
var deleteNumbers = Set<Int>()

let countNumbers    = 100
var p               = 2

for i in p..<countNumbers+p{
    arrayPrimeNumbers.append(i)
}

var findNum         = p
var valueInc        = p

var needRepeat = true
while needRepeat {
    
    let countBefore = deleteNumbers.count
    
    for num in arrayPrimeNumbers {
        
        if findNum == valueInc {
            findNum = findNum + valueInc
        }
        
        if num == findNum {
            findNum = num + valueInc
            deleteNumbers.insert(num)
        }
    }
    
    let countAfter = deleteNumbers.count
    
    if countBefore == countAfter {
        needRepeat = false
    } else {
        if findNum >= arrayPrimeNumbers.max()! {
            valueInc += 1
            findNum = valueInc
        }
    }
}

arrayPrimeNumbers = arrayPrimeNumbers.filter { (num) -> Bool in
    !deleteNumbers.contains(num)
}
