import UIKit

// Задача 1
// ----------------
/*
 В данной задаче вы тренируетесь добавлять и удалять значения в Хранилище (массив) при помощи двух функций,
 которые вам и нужно реализовать. Функции принимают значение, но ничего не возвращают.
 Первая функция добавляет элемент в массив, вторая функция удаляет элемент из массива,
 вы сами можете выбрать любой удобный для вас вариант добавления и удаления элементов из массива.

 Алгоритм решения:

 1.Создайте пустой массив строк типа String на любимую тематику, например, это
 будет Хранилище столовых приборов (этот пример не использовать), в который вы будете
 поочередно добавлять или удалять ложки, вилки и другие приборы.
 42. Создайте 2 функции в соответствии с условием.
 3. Попробуйте добавлять и удалять значения в массиве при помощи созданных функций.
 4. Что произойдет, если попытаетесь удалить значение, которого нет в Хранилище?
    Напишите, что в этом случае вы можете изменить в своей функции и внесите в нее изменения.
 5.Условие со звездочкой (необязательное для выполнения): обе функции должны принимать массив и значение. Они должны добавлять или удалять значения в массиве. Функция удаления должна быть безопасной, т.е. если Хранилище пустое, мы должны сообщить об этом пользователю, если запрашиваемое на удаление значение отсутствует, необходимо также сообщить, что такого элемента нет. Запрещается использование forced unwrapping, если в вашем варианте будет необходимость работать с опциональными значениями.
*/
print("Задача 1")

var arrayCustomerFio: [String] = []
var resultOperText: String = ""

//------------------------
func addCustomerFioToArray(_ nameItem: String) -> Void {
    arrayCustomerFio.append(nameItem)
}

func delCustomerFioFromArray(_ nameItem: String) -> Void {
    if let index = arrayCustomerFio.firstIndex(of: nameItem) {
        arrayCustomerFio.remove(at: index)
    }
}
//------------------------
func addToArray(_ customerArray: inout [String] , _ nameItem: String) -> Void {
    customerArray.append(nameItem)
}

func delFromArray(_ customerArray: inout [String] , _ nameItem: String, _ resultText: inout String) -> Bool {
    var res: Bool
    if customerArray.isEmpty {
        resultText = "Array is empty."
        res = false
    }
    else {
        if let ii = customerArray.firstIndex(of: nameItem) {
            customerArray.remove(at: ii)
            resultText = "Successfully completed"
            res = true
        }
        else {
            resultText = "Item '\(nameItem)' not exist."
            res = false
        }
    }
    return res
}


arrayCustomerFio.removeAll()
addCustomerFioToArray("Абрамов")
print("Step 1. Add:",arrayCustomerFio)
addCustomerFioToArray("Ибрагимов")
print("Step 2. Add:",arrayCustomerFio)
addCustomerFioToArray("Гафиатуллин")
print("Step 3. Add:",arrayCustomerFio)
addCustomerFioToArray("Аблудкаримов")
print("Step 4. Add:",arrayCustomerFio)

//Для безопасного удаления элемента в функции реализовано раскрытие опционала индекса искомого элемента массива
//При такой реализации удаление не существующего элемента не привет к ошибке
//Удаление не существующего элемента
delCustomerFioFromArray("Петров")
print("Step 5. Del:",arrayCustomerFio)

//Удаление существующего элемента
delCustomerFioFromArray("Гафиатуллин")
print("Step 6. Del:",arrayCustomerFio)

//Работа с функцией с передачей "сквозных" параметров

addToArray(&arrayCustomerFio,"Гвоздиков")
print("Step 7. ",arrayCustomerFio)

//Успешние удаление элемента
print("Step 8. ",delFromArray(&arrayCustomerFio,"Аблудкаримов",&resultOperText) ? arrayCustomerFio : resultOperText)

//Удаление не существующего элемента
print("Step 9. ",delFromArray(&arrayCustomerFio,"Молотков",&resultOperText) ? arrayCustomerFio : resultOperText)

//Удаление из пустого массва
arrayCustomerFio.removeAll()
print("Step 10. ",delFromArray(&arrayCustomerFio,"Молотков",&resultOperText) ? arrayCustomerFio : resultOperText)

print("-------------------------")

// Задача 2
// ----------------
/*
 Вы получили тестовое задание от службы доставки еды: преобразовать бонусные баллы клиентов, которые хранятся на сайте, в денежные единицы. Со стороны сайта приходит словарь, содержащий ID клиента (Int) и накопленную сумму Бонусов (Double). Ваша задача вернуть на сайт словарь, содержащий ID клиента (Int) и конвертированные денежные единицы (Int), каждые 100 бонусов равны 10 денежным единицам.

 Алгоритм решения:

 1. Словарь со своими значениями создавать не нужно. Значения, с которыми вы будете работать, инкапсулированы и переданы в userPoints.
 2. Распечатайте словарь и посмотрите, с какими значениями вы будете работать.
 3. Создайте функцию, которая принимаем словарь, ключом которого будет тип Integer, значением число с плавающей точкой Double, вернуть необходимо словарь ключом и значением, которого будет Integer.
 4. Вызовите функцию и распечатайте полученный результат.
 5. Дополнительно (необязательно) входящих параметров может быть больше, например, для коэффициента пересчета баллов в денежные единицы.
 */

print("Задача 2")

//Вариант 1
var userPointGrade: [Int:Int]=[:]

func calcGrade(_ userPoints: [Int:Double],koefMonеy: Double = 10,koefGrade: Int = 100) -> [Int:Int] {
    var resultGrade: [Int:Int] = [:]
    for userPoint in userPoints {
        resultGrade[userPoint.key] = Int(userPoint.value/koefMonеy)*koefGrade
    }
    return resultGrade
}

func calcGrade(_ userPoints: [Int:Double],recalcFunc:(Double)->Int) -> [Int:Int] {
    var resultGrade: [Int:Int] = [:]
    for userPoint in userPoints {
        resultGrade[userPoint.key] = recalcFunc(userPoint.value)
    }
    return resultGrade
}

print("---------------------- Один параметр")
userPointGrade = calcGrade(userPoints)
userPointGrade.forEach({print("V1",$0.key,$0.value,userPoints[$0.key] ?? 0.0, separator: "\t")})

print("---------------------- Несколько параметров")
userPointGrade = calcGrade(userPoints,koefMonеy: 200.0,koefGrade: 1)
userPointGrade.forEach({print("V2",$0.key,$0.value,userPoints[$0.key] ?? 0.0, separator: "\t")})

print("---------------------- Параметр-функция")
userPointGrade = calcGrade(userPoints,recalcFunc:{Int($0/1000)*10})
userPointGrade.forEach({print("V3",$0.key,$0.value,userPoints[$0.key] ?? 0.0, separator: "\t")})

print("---------------------- Пересчет через mapValue")
userPointGrade = userPoints.mapValues({value in Int(value/10)*100})
userPointGrade.forEach({print("V4",$0.key,$0.value,userPoints[$0.key] ?? 0.0, separator: "\t")})
print("-------------------------")

// Задача 3
// ----------------
/*
 Вам необходимо реализовать функцию, которая принимаем массив опциональных значений типа Integer и возвращает кортеж, в который необходимо передать сумму четных и нечетных значений.

 Массив может содержать повторяющиеся и nil значения, например: [1, 2, nil, 12, 1, nil, 3, 2].
 В вычислении должны быть использованы только уникальные значения, а повторяющиеся учитываться не должны. Например, у нас повторяются числа 1 и 2, но попадать в результат они должны один раз; сумма нечетных будет (1 + 3 = 4), четных (2 + 12 = 14).
 Так как в массиве могут быть nil, а вернуть необходимо не опциональное значение, необходимо использовать безопасное развертывание опционала (optional binding).
 Для проверки вашего решения передайте в функцию подготовленный массив arrayOfNumbers.
 Массив со своими значениями создавать не нужно. Значения, с которыми вы будете работать, инкапсулированы и переданы в arrayOfNumbers.
 Распечатайте массив и посмотрите, с какими значениями вы будете работать.
 Если вы все правильно сделаете, то получите ответ: сумма четных: 1378, нечетных: 1304.
 */

print("Задача 3")

func calc(arrayNum: [Int?]) -> (sumEven:Int,sumNotEven:Int) {
    let setNum: Set<Int?> = Set(arrayNum)
    var sumEven: Int = 0
    var sumNotEven: Int = 0
    for num in setNum {
        if let ii = num {
            if ii%2 == 0 {
                sumEven += ii
            }
            else {
                sumNotEven += ii
            }
        }
    }
    return (sumEven,sumNotEven)
}

print("---------------------- Исходный массив")
print(arrayOfNumbers)
print("---------------------- Результат с использованием функции (сумма четных, сумма не четных)")
print(calc(arrayNum:arrayOfNumbers))
print("---------------------- Результат с использованием compactMap+reduce (сумма четных, сумма не четных)")

let resultTulpe:(sumEven:Int,sumNotEven:Int) = Set(arrayOfNumbers.compactMap{ii in ii})
                                              .reduce(into:(0,0), { res, ii in if ii%2 == 0 {res.0 += ii} else { res.1 += ii} } )
print(resultTulpe)
