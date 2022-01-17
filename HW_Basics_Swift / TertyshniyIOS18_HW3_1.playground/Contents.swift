import UIKit

// Задача 1
// ----------------
/*
 Вы работаете над приложением "Электронный дневник", ваша задача подготовить
 загрузку списков студентов в приложение и дальнейшую работу с данными.
 Создайте массив с именами из 2 студентов мальчиков, затем создайте другой массив из 3 студенток девочек.
 После чего создайте 3 массив 'students' и присвойте ему значения массива с именами девочек.
 Затем при помощи цикла for добавьте в массив 'students' массив с именами мальчиков так,
 чтобы имена мальчиков оказались в начале обшего массива.
*/
print("Задача 1")

var groupBoy:  [String] = ["Alex","Bob"]
var groupGirl: [String] = ["Lina","Miki","Naomi"]
var students:  [String] = []

if !students.isEmpty {
  students.removeAll()
}
students=groupGirl

if !groupBoy.isEmpty {
  for ii in 0..<groupBoy.count {
    students.insert(groupBoy[ii], at:ii)
  }
}

print("students =\(students)")
print("-------------------------")

// Задача 2
// ----------------
/*
 Используя массив 'students' из первого задания, отсортируйте список студентов по алфавиту и выведите содержимое в консоль.
 Для выполнения задания попрактикуйтесь с функцией sort().
 */
print("Задача 2")
students.sort(by: < )
print("students sort asc =\(students)")
students.sort(by: {$0 > $1} )
print("students sort desc =\(students)")
print("-------------------------")
students.sort(by: {($0 > $1 && $0 > "L") || ($0 < $1 && $0 <= "L")} )
print("students sort ^ =\(students)")
students.sort(by: {($0 > $1 && $0 < "L") || ($0 < $1 && $0 >= "L")} )
print("students sort V =\(students)")
print("-------------------------")

// Задача 3
// ----------------
/*
 Вы работаете над фильтром товаров на главной странице магазина.
 Нужно показывать только товары с положительными оценками.
 Для этого вам потребуется обращаться к массиву с оценками и отбирать только положительные числа.
 */

print("Задача 3")

let maxCountArray: Int = 30
var graidProduct: [Int] = []
var positiveGraidProduct: [Int] = []
var negativeGraidProduct: [Int] = []

if !graidProduct.isEmpty {
    graidProduct.removeAll()
}
for _ in 0..<maxCountArray {
    graidProduct.append(Int.random(in: -5...5))
}

print("graidProduct = \(graidProduct)")
positiveGraidProduct = graidProduct.filter({$0>0})
negativeGraidProduct = graidProduct.filter({$0<0})
print("positiveGraidProduct = \(positiveGraidProduct)")
print("negativeGraidProduct = \(negativeGraidProduct)")

graidProduct.sort()
print("graidProduct.sort = \(graidProduct)")
print("-------------------------")

// Задача 4
// ----------------
/*
 Дан массив [1, 2, 3, 4, 7, 8, 15].
 Программно найдите индексы двух чисел, которые в сумме дают 6, и распечатайте их в консоль.
*/

print("Задача 4")
let findSum: Int = 6
var numArray: [Int] = [1, 2, 3, 4, 7, 8, 15]
var numIndex: [Int] = []

if !numArray.isEmpty {
    for ii in 0..<numArray.count-1 {
        for jj in ii+1..<numArray.count {
            if numArray[ii]+numArray[jj] == findSum {
                print("первый элемен [\(ii)]=\(numArray[ii]), второй элемент [\(jj)]=\(numArray[jj]), сумма  \(findSum)" )
            }
        }
    }
}
print("-------------------------")
