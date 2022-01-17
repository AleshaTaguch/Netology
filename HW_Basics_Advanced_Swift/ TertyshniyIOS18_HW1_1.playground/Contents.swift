import UIKit

// Задача 1
// ----------------
/*
 Для каждого принципа ООП приведите 2-3 примера из жизни.
  - Абстракция
  - Инкапсуляция
  - Наследование
  - Полиморфизм
*/

/*
 Абстракция - все что ни же описано - это абстрактное описание объектов
 
 Абстракция и инкапсуляция:
 
 Описываем "Источник света" без деталей реализации. Описание объекта содержит как свойство (данные) объекта, так и методы управления свойствами (данными) объекта.
 
 "Источник света" определяется свойствами:
  - максимальная яроксть
  - цвет (RGB)
  - коефициент (0...1) свечения
  - текущий статус включения (включен, выключен)
  - текущий статус подключения питания (подключено, отключено)
  и имеет методы управления:
  - установить максимальную яроксть (при создании объекта)
  - установить максимальную
  - изменить текущий цвет
  - получить текущи цвет
  - включить
  - включить
  - переключить
  - получить текущий статус включения
  - подключить
  - отключить
  - переключить
  - подключить статус подкючени
 
 */

protocol LigthPointProperty {
    var maxBrightness: UInt { get }
    var color: UInt { get }
    var powerCoeficient: Float { get }
    var isOn: Bool { get }
    var isConnected: Bool { get }
}

protocol LigthPoint: LigthPointProperty {
    func setMaxBrightness(value: UInt) -> UInt
    func setColor(value: UInt) -> UInt
    func setPowerCoeficient(value: Float) -> Float
    func on() -> Void
    func off() -> Void
    func onOffSwitch() -> Bool
    func connect() -> Void
    func disconnect() -> Void
    func switchConnection() -> Bool
}

/*
 
 Наследование
 
 Создаем класс "Диодный источник света" удовлетворяжщего протоколу "источник света и создаем
 класс "Лампочка" наследует, который наследует свойства класса "Диодный источник света" и содержит свои свойства
 - форма
 - размер
 и  метод
 - нарисовать
 - установить свойство формы и размера лапы
 - получить форму и размер лампы
 
*/
class DiodLigthPoint: LigthPointProperty, LigthPoint {
    var maxBrightness: UInt
    var color: UInt
    var powerCoeficient: Float
    var isOn: Bool
    var isConnected: Bool
    
    init() {
        maxBrightness = 0
        color = 0
        powerCoeficient = 1
        isOn = false
        isConnected = true
    }
    init(maxBrightnessValue: UInt, colorValue: UInt ) {
        maxBrightness = maxBrightnessValue
        color = colorValue
        powerCoeficient = 1
        isOn = false
        isConnected = true
    }
    func setMaxBrightness(value: UInt) -> UInt {
        maxBrightness = value
        return maxBrightness
    }
    func setColor(value: UInt) -> UInt {
        color = value
        return color
    }
    func setPowerCoeficient(value: Float) -> Float {
        powerCoeficient = value
        return powerCoeficient
    }
    func on() -> Void { isOn = true }
    func off() -> Void { isOn = false  }
    func onOffSwitch() -> Bool {
        isOn = !isOn
        return isOn
    }
    func connect() -> Void { isConnected = true }
    func disconnect() -> Void { isConnected = false  }
    func switchConnection() -> Bool {
        isConnected = !isConnected
        return isConnected
    }
}

class DiodLamp: DiodLigthPoint {
    var size: Int
    var form: Int
    init(sizeValue: Int, formValue: Int ) {
        self.size = sizeValue
        self.form = formValue
        super.init()
    }
    func drow() -> Void {
        //как то ресуем объкт
        return
    }
    func setSize(value: Int ) -> Void {
        self.size = value
    }
    func setForm(value: Int ) -> Void {
        self.form = value
    }
}
/*
 
 Инкапсуляция и полиморфизм.
 В объектах "Бра", "Люстра","Световая лента", "Настольная лампа", "Фанарик" инкапсулируем
 внутрь массим объектов "Лампочка" и функию отрисовки. В результате управления всеми перечислеными
 объектам выполняется одноименными методами - это полиморфизм.
 Это примеры объектов
 */

 class DecorateLamp {
    let lamps: [DiodLamp] = []
    var coordidate: [Int] = []
    var isOn: Bool = false
    
    func onOffSwitch() -> Bool {
        isOn = !isOn
        return isOn
    }
 }

/*
 "Бра" содержит свойства
 - массив типа "Лампочка"
 - массив типа "Координаты Лампочек"
 и метод
 - нарисовать
 
 */

class Sconce: DecorateLamp {
    func drow() -> Void {
      // как то тут рисуем
      return
    }
}


/*
 "Люстра" содержит свойства
 - массив типа "Лампочка"
 - массив типа "Координаты Лампочек"
 и метод
 - нарисовать
 */

class Сhandelier: DecorateLamp {
    func drow() -> Void {
      // как то тут рисуем
      return
    }
}

/*
 "Световая лента" содержит свойства
 - массив типа "Лампочка"
 - массив типа "Координаты Лампочек"
 и метод
 - нарисовать
 
 */

class LigthLine: DecorateLamp {
    func drow() -> Void {
      // как то тут рисуем
      return
    }
}

/*
 "Настольная лампа" содержит свойства
 - массив типа "Лампочка"
 - массив типа "Координаты Лампочек"
 и метод
 - нарисовать
 */

class TableLamp: DecorateLamp {
    func drow() -> Void {
      // как то тут рисуем
      return
    }
}

/*
 "Фанарик" содержит свойства
 - массив типа "Лампочка"
 - массив типа "Координаты Лампочек"
 и метод
 - нарисовать
 
 */

class Lantern: DecorateLamp {
    func drow() -> Void {
      // как то тут рисуем
      return
    }
}

// Задача 2
// ----------------
/*
 Для каждого базового понятия ООП приведите 2-3 примера из жизни. Опишите их текстом.

 Класс
 Объект
 Свойства объектов
 Методы
 
*/

/*
 В выше описаном примере с Источнками света
 Класс - это описание типов "Бра", "Люстра", "Световая лента" и т.д.
*/


/*
 Объект - это переменные типа "Бра", "Люстра", "Световая лента", которомы выделена память и к ним можно обратится и получить значения
*/
let meDiodLamp = DiodLamp(sizeValue: 10, formValue: 33)
let meTableLamp = TableLamp()
let meLantern = TableLamp()

/*
 Свойства объектов - переменные и константы объекта. Как правило они содержат информацию, определяющие характер поведения объектов.
 Например в выше опсанном это "максимальная яроксть", "цвет (RGB)" у объектов "Источник света",
 "форма" и "размер" у объектов "Лампочка", "массив типа "Лампочка"" у объектов "Настольная лампа",  "Фанарик".
*/

print(meTableLamp.isOn)
print(meDiodLamp.color)
print(meLantern.coordidate)

/*
 Методы - функции, принадлежащие объектам, которые управляют свойствам и поведением объектов
 Например в выше опсанном это метод "Нарисовать".
 
 */

meDiodLamp.connect()
meDiodLamp.on()

meTableLamp.onOffSwitch()


