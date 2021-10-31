import UIKit

// Задача 1
// ----------------

print("-------------------------")
print("Задача 1")

var   employeeSalary1: Float
var   employeeSalary2: Float
var   employeeSalary3: Float

employeeSalary1 = 55000.00
employeeSalary2 = 40000.00
employeeSalary3 = 70000.00

employeeSalary1 = employeeSalary1 * 2
employeeSalary2 = employeeSalary2 + 15000
employeeSalary3 = employeeSalary3 + 0

print("Исходные данные")
print("Новая зарплата: сотрудник 1 = \(employeeSalary1)")
print("Новая зарплата: сотрудник 2 = \(employeeSalary2)")
print("Новая зарплата: сотрудник 3 = \(employeeSalary3)")

// Условние задачи 1---------------------------------
// Cоставить Операции сравнения и вывести в консоль результат выполнения (все данные о зарплате брать после повышения):

var conditionText: String
var resutlConditon: Bool

func makeConsoleText(text: String, result: Bool) -> String {
    let textTrue: String  = "Условие выполнено:"
    let textFalse: String = "Услование НЕ выполнено:"
    return((result ? textTrue : textFalse)+" "+text)
}
 
// Зарплата первого больше зарплаты третьего.
conditionText = "Зарплата первого [\(employeeSalary1)] больше зарплаты третьего [\(employeeSalary3)]."
resutlConditon = employeeSalary1 > employeeSalary3
print(makeConsoleText(text: conditionText,result: resutlConditon))

// Заплата второго меньше зарплаты первого.
conditionText = "Заплата второго [\(employeeSalary2)] меньше зарплаты первого [\(employeeSalary1)]."
resutlConditon = employeeSalary2 < employeeSalary2
print(makeConsoleText(text: conditionText,result: resutlConditon))

//   Заплата первого больше зарплаты второго ИЛИ зарплата третьего меньше зарплаты второго
conditionText = "Заплата первого [\(employeeSalary1)] больше зарплаты второго [\(employeeSalary2)] ИЛИ зарплата третьего [\(employeeSalary3)] меньше зарплаты второго [\(employeeSalary2)]"
resutlConditon = employeeSalary1 > employeeSalary1 || employeeSalary3 < employeeSalary2
print(makeConsoleText(text: conditionText,result: resutlConditon))

//   Зарплата третьего меньше зарплаты первого И Зарплата второго больше зарплаты первого
conditionText = "Зарплата третьего [\(employeeSalary3)] меньше зарплаты первого [\(employeeSalary1)] И Зарплата второго [\(employeeSalary2)] больше зарплаты первого [\(employeeSalary1)]."
resutlConditon = employeeSalary3 < employeeSalary1 && employeeSalary2 > employeeSalary1
print(makeConsoleText(text: conditionText,result: resutlConditon))


// Задача 2
// ----------------

print("-------------------------")
print("Задача 2")

// У вас есть 3 числа A, B, C и формула D = B * B - 4AC, где D — возможное движение графика.
let numA: Float = 2
let numB: Float = 2
let numC: Float = 3
let numD: Float = numB * numB - 4 * numA * numC

enum DerectionType {
    case contant //продолжит направление
    case change  //поменяет направление
    case wait    //нужно ждать
}
var resultDerection: DerectionType

//Если D > 0, график скорее всего продолжит направление;
//Если D < 0, график скорее всего поменяет направление;
//Если D = 0, неопределенная ситуация — нужно ждать.
//Выведите в консоль строку, указывающую движение графика, в зависимости от полученного D.

//вариант 1
if numD > 0 {
    resultDerection = .contant
} else if numD < 0 {
    resultDerection = .change
}
else {
    resultDerection = .wait
}
print ("Вариант 1. Напраление графика \(resultDerection) при значении D=\(numD)" )

//вариант 2
resultDerection = .wait
resultDerection = numD > 0 ? .contant : (numD<0 ? .change : .wait)
print ("Вариант 2. Напраление графика \(resultDerection) при значении D=\(numD)" )

//Вариант 3
switch numD {
case let num where num>0:
  resultDerection = .contant
case let num where num<0:
  resultDerection = .change
default:
  resultDerection = .wait
}
print ("Вариант 2. Напраление графика \(resultDerection) при значении D=\(numD)" )



// Задача 3
// ----------------

print("-------------------------")
print("Задача 3")

enum SexType {
    case male
    case female
}

//-------------------------------------
// исходные параметры
let sexMan: SexType = .female
let ageMan: Int = 55
//-------------------------------------

var resutText: String

switch ageMan {
  case 3...17:  resutText = "Детский контент \(sexMan == .female ? "для девочек" : "для мальчиков")"
  case 18...65: resutText = "Взрослый контент \(sexMan == .female ? "для женщин" : "для мужчин")"
  case 66...:   resutText = "Контент \(sexMan == .female ? "для женщин" : "для мужчин") пожилого возраста"
  default:     resutText = "Недопустипый возраст"
}

print(resutText)
