import UIKit

// Задача 1
// ----------------
/*
 Работа с кортежами
 Вы работаете над приложением "Информация о вас и ваших друзьях".
 Ваша задача создать список людей с минимальной информацией о них и
 объединить одно из полей для создания общего значения.

 Алгоритм выполнения
 1. Создайте кортеж с тремя параметрами: ваш любимый фильм, ваше любимое число и ваше любимое блюдо.
    Все элементы кортежа должны быть именованы.
 2. Одним выражением запишите каждый элемент кортежа в три константы.
 3. Создайте второй кортеж, аналогичный первому по параметрам, но описывающий другого человека (с другими значениями).
 4. Обменяйте значения в кортежах между собой (с использованием дополнительного промежуточного кортежа).
 5. Создайте новый кортеж, элементами которого будут любимое число из первого кортежа,
    любимое число из второго кортежа и разница любимых чисел первого и второго кортежей.
*/

print("Задача 1")

typealias PropertyFriend = (filmName: String, numberFavorite: Int, dishFavorite: String )
var propertyFriend1:PropertyFriend
var propertyFriend2:  PropertyFriend
var propertyFriendTmp:PropertyFriend

propertyFriend1 = (filmName: "Армагедон",numberFavorite: 123,dishFavorite: "Суп")
print("1.propertyFriend1=\(propertyFriend1)")
let (filmNameConst,numberFavoriteConst,dishFavoriteConst) = propertyFriend1

propertyFriend2 = (filmName: "Тертминатор",numberFavorite: 5445,dishFavorite: "Шашлык")
print("1.propertyFriend2=\(propertyFriend2)")
propertyFriendTmp = propertyFriend1
propertyFriend1   = propertyFriend2
propertyFriend2   = propertyFriendTmp

print("2.propertyFriend1=\(propertyFriend1)")
print("2.propertyFriend2=\(propertyFriend2)")
let propertyFriendNumber:(numberFavorite1: Int,numberFavorite2: Int, numberFavoriteDiff: Int)

propertyFriendNumber = ( numberFavorite1: propertyFriend1.numberFavorite
                        ,numberFavorite2: propertyFriend2.numberFavorite
                        ,numberFavoriteDiff: propertyFriend1.numberFavorite-propertyFriend2.numberFavorite
                       )
print("propertyFriendNumber=\(propertyFriendNumber)")
print("-------------------------")

// Задача 2
// ----------------
/*
 Представьте, что вы работаете над приложением электронный дневник.
 Создайте словарь, где ключом будет имя студента, а значением будет другой словарь
 из 3 элементов, содержащий название предмета и оценку.
*/
print("Задача 2")

typealias GradeDictionary = [String:Int]
typealias StudentDictionary = [String:GradeDictionary]

var studentsWihGrade: StudentDictionary = [:]

studentsWihGrade["Иванов Иван Иванович"] = ["Метематика":5, "История":3, "Физика":4]
studentsWihGrade["Петров Петр Петрович"] = ["Метематика":5, "Физкультура":3, "Русский Язык":4]
studentsWihGrade["Васильев Василий Васильевич"] = ["Метематика":3, "ИзоИскуство":5, "Русский Язык":4]

for stud in studentsWihGrade {
    for grade in stud.value {
        print("\(stud.key) \t \(grade.key) \t \(grade.value)")
    }
}
print("----------v2---------------")
studentsWihGrade.forEach {st in st.value.forEach { gr in print("\(st.key) \t \(gr.key) \t \(gr.value)")}}
print("-------------------------")


// Задача 3
// ----------------
/*
 Вы разрабатываете приложение "Шахматы". Вашей задачей будет создать фигуру на игровом поле.

 Создайте псевдоним типа (typealias) Chessman для типа словаря [String: (alpha:Character, num: Int)?].
 Данный тип описывает шахматную фигуру на игровом поле.
 В ключе словаря должно храниться имя фигуры, например «Белый король», а в значении — кортеж,
 указывающий на координаты фигуры на игровом поле. Если вместо кортежа находится nil,
 это означает, что фигура убита (не имеет координат на игровом поле).

 Создайте переменный словарь Chessmans типа Chessman и добавьте в него три произвольные фигуры,
 одна из которых не должна иметь координат.

 Создайте конструкцию if-else, которая проверяет, убита ли переданная ей фигура (элемент словаря Chessmans),
 и выводит на консоль информацию либо о координатах фигуры, либо о ее отсутствии на игровом поле.
*/

print("Задача 3")

typealias CoordinateChessman = (alpha:Character, num: Int)
typealias Chessman = [String: CoordinateChessman?]

let nilCoordinate: CoordinateChessman? = nil
var chesmans:Chessman = [:]

func getCoordinatChessmanText(coordinate: CoordinateChessman??) -> String {
    var chesmansCoordinateText: String = ""
    if let cd0 = coordinate {
        if let cd1 = cd0 {
            chesmansCoordinateText = String(cd1.alpha) + "-" + String(cd1.num)
        }
        else {
            chesmansCoordinateText = "Chessman is kill"
        }
    }
    else {
        chesmansCoordinateText = "Chessman not found"
    }
    return chesmansCoordinateText
}

chesmans["Б.Король"] = (alpha:"E", num:1)
chesmans["Б.Ферзь"]  = (alpha:"E", num:2)
chesmans["Б.Ладья"]  = (alpha:"F", num:2)
chesmans["Б.Слон"]   = nilCoordinate

print( "Б.Ладья ",getCoordinatChessmanText(coordinate: chesmans["Б.Ладья"]) )
print( "Б.Слон " ,getCoordinatChessmanText(coordinate: chesmans["Б.Слон"] ) )
print( "Б.Пешка ",getCoordinatChessmanText(coordinate: chesmans["Б.Пешка"]) )
print("-------------------------")


// Задача 4
// ----------------
/*

 Вам необходимо доработать программу из Задачи 3 таким образом,
 чтобы она автоматически анализировала не одну переданную ей фигуру,
 а все фигуры, хранящиеся в переменной Chessmans.
*/

print("Задача 4")

for chesmansRow in chesmans {
    print("\(chesmansRow.key) \t \(getCoordinatChessmanText(coordinate: chesmansRow.value))")
}

print("-------------------------")
