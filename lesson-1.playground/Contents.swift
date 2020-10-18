import UIKit

// 1. Решить квадратное уравнение.
// Сначала была идея всем переменным присвоить тип Double, а потом решил это сделать только при вычислении корня
// ax2 + bx + c = 0
var a = 1
var b = -2
var c = -3

// d = b2-4ac
var d = b * b - 4 * a * c

var sqrtd = Int(sqrt(Double(d)))
var x1:Int
var x2:Int

if d > 0  {
    x1 = (-b + sqrtd) / 2 * a
    x2 = (-b - sqrtd) / 2 * a
    print("Корни: \(x1) и \(x2).")
} else if (d == 0) {
    x1 = (-b + sqrtd) / 2 * a
    print("Корень: \(x1).")
} else if (d < 0) {
    print("Корней нет")
}

// 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

a = 5
b = 6

var s = (a * b) / 2
var p = a + b + c
var c2 = sqrt(Double(a * a + b * b))

print("Площадь: \(s). Периметр: \(p). Гипотенуза: \(c2)")

// 3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
// Будем считать, что сумма процентов начисленных за каждый год учитывется при расчете в следюущем году

var depositAmount   = 100000
var interestRate    = 10
var yearsCount      = 5
var sum             = depositAmount

var i = 0
while yearsCount > i {
    i += 1
    sum += (sum * interestRate) / 100
}

print("Сумма вклада через \(yearsCount) лет: \(sum)")

