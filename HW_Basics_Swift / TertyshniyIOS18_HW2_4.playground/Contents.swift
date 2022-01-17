import UIKit

// Задача 1
// ----------------
/*
  Создайте три опциональные строковые переменные. Первые две проинициализируйте значениями, оставшуюся переменную
  проинициализируйте значением nil. При помощи nil-coalescing оператора выведите каждое значение в консоль с новой строки.
  Затем присвойте 3-й переменной значение и выведите его в консоль, используя nil-coalescing оператор.
  Есть ли разница между выводами в случае, когда переменная не имела значения и после присвоения.
  Создать пять строковых констант. Одни константы это только цифры, другие содержат еще и буквы.
  Найти сумму всех этих констант приведя их к Int. (Используйте optional binding и forced unwrapping)
*/

print("-------------------------")
print("Задача 1")

var str1: String? = "Значение первой строки"
var str2: String? = "Значение второй строки"
var str3: String? = nil

print("str1 --> \(str1 ?? "")")
print("str2 --> \(str2 ?? "")")
print("str3 --> \(str3 ?? "")")

str3 = "Значение третьей строки"

print("str3 --> \(str3 ?? "")")

//Вопрос: Есть ли разница между выводами в случае, когда переменная не имела значения и после присвоения?
//Ответ : Разницы нет, потому что происходит раскрытие опционала

//Вариант функции для раскрытия функционала через "force unwrap operator"
func openOptionalInt1(num: Int?) -> Int {
    var res: Int = 0
    if num != nil {
        res = num!
    }
    return res
}
//Вариант функции для раскрытия функционала через "optional binding"
func openOptionalInt2(num: Int?) -> Int {
    var res: Int = 0
    if let numValue = num {
        res = numValue
    }
    return res
}

let strConst1: String = "111"
let strConst2: String = "F99"
let strConst3: String = "333"
let strConst4: String = "1oo"
let strConst5: String = "555"

var res: Int

print("Варинат force unwrap operator:")
res = openOptionalInt1(num : Int(strConst1)) +
      openOptionalInt1(num : Int(strConst2)) +
      openOptionalInt1(num : Int(strConst3)) +
      openOptionalInt1(num : Int(strConst4)) +
      openOptionalInt1(num : Int(strConst5))
print("strConst1 + strConst2 + strConst3 + strConst4  + strConst5 = \(res)")

print("Варинат optional binding:")
res = openOptionalInt2(num : Int(strConst1)) +
      openOptionalInt2(num : Int(strConst2)) +
      openOptionalInt2(num : Int(strConst3)) +
      openOptionalInt2(num : Int(strConst4)) +
      openOptionalInt2(num : Int(strConst5))
print("strConst1 + strConst2 + strConst3 + strConst4  + strConst5 = \(res)")



// Задача 2
// ----------------
/*
  Создайте опциональную константу с типом данных Optional<Int>. Проинициализируйте конструктором преобразования строки в целое число Int(String).
  Вместо String впишите температуру за окном. При помощи конструкции if else выведите в консоль информационные сообщения,
  например для таких случаев, температура:
    Больше нуля;
    Меньше нуля;
    Меньше -10 градусов;
    Больше 10 градусов;
    Нет значения (nil).
    Например, если температура -25 градусов, можно вывести в консоль сообщение “Это что, Сибирь?”
*/

print("-------------------------")
print("Задача 2")

let temperatureValueText: String = "6"
var temperatureValue: Optional<Int>

temperatureValue = Int(temperatureValueText)

if let tValue = temperatureValue {
    if      tValue > 10  { print("Температура плюсовая и на улице тепло.") }
    else if tValue > 0   { print("Температура плюсовая, но еще не так чтобы тепло.") }
    else if tValue == 0  { print("Просто ноль.") }
    else if tValue < -10 { print("Температура отрицательная и надо уже одется тепло.") }
    else if tValue < 0   { print("Температура отрицательная и .") }
} else {
    print("Температуры нет, проверьте градусник")
}

