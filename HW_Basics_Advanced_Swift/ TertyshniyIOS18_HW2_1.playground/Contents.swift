import UIKit

// Задача 1
// ----------------
/*
 Представьте себя инженером проектировщиком телевизоров во времена, когда эпоха телевещания только набирала обороты.
 Вам поступила задача создать устройство для просмотра эфира в домашних условиях "Телевизор в каждую семью".

 Вам нужно реализовать перечисление "Телевизионный канал" с 5-7 каналами.

 Алгоритм выполнения
 1. Реализуйте класс "Телевизор". У него должны быть состояния:
   - фирма/модель (реализовать одним полем);
   - включен/выключен;
   - текущий телеканал;
 2. У него должно быть поведение:
   - показать, что сейчас по телеку
 3. Вызовите метод и покажите, что сейчас по телеку.

 4. Сделайте изменение состояний телевизора (на свой выбор).

 5. Повторите вызов метода и покажите, что сейчас по телеку.
*/

enum  DeviceStatus: String{
    case off = "Выключен"
    case on  = "Включен"
}

enum ButtonUpDown: Int {
    case up = 1
    case down = -1
}

enum  RemoteButton {
    case powerOnOff
    case colorSwitch
    case channelUp
    case channelDown
    case volumelUp
    case volumeDown
    case channel_1
    case channel_2
    case channel_3
    case channel_4
    case channel_5
    case channel_6
    case channel_7
    case channel_8
    case channel_9
    case channel_0
    case sourceSwitch
}

enum  TVChannel: String, CaseIterable {
    case channel1 = "Первый канал"
    case channel2 = "Россия 1"
    case channel3 = "НТВ"
    case channel4 = "СТС"
    case channel5 = "Sport"
    case channel6 = "MusTV"
}

struct DeviceProperty {
    var brаnd: String
    var model: String
}

class TVSet {
    let property: DeviceProperty
    private var status: DeviceStatus
    private var currentChannel: TVChannel

    var deviceStatus: DeviceStatus {
        get {return self.status}
    }
    
    init(property: DeviceProperty){
        self.property = property
        self.status = .off
        self.currentChannel = .channel1
    }
    
    func getCurrentChenalInfo() -> String {
        switch status {
        case .off:
            return "Device OFF."
        default:
            return "\(currentChannel) : \(currentChannel.rawValue)"
        }
    }

    func pressButton(on button: RemoteButton) -> Void {
        switch button {
        case .powerOnOff:
           onOffSwitch()
        case .channelUp:
            changeChannel(direction: .up)
        case .channelDown:
            changeChannel(direction: .down)
        case .channel_1:
            setChannel(value: .channel1)
        case .channel_2:
            setChannel(value: .channel2)
        case .channel_3:
            setChannel(value: .channel3)
        case .channel_4:
            setChannel(value: .channel4)
        case .channel_5:
            setChannel(value: .channel5)
        case .channel_6:
            setChannel(value: .channel6)
        default:
            return
        }
    }
    
    private func onOffSwitch() -> DeviceStatus {
        switch status {
        case .off:
            status = .on
        default:
            status = .off
            currentChannel = .channel1
            
        }
        return status
    }
    
    private func setChannel(value: TVChannel) -> Void {
        if status == .on {
            currentChannel = value
        }
    }
    
    private func changeChannel(direction: ButtonUpDown) -> Void {
        if var index = TVChannel.allCases.firstIndex(of: currentChannel) {
            index += direction.rawValue
            if index > TVChannel.allCases.count-1 {
                index = 0
            } else if index < 0 {
                index = TVChannel.allCases.count-1
            }
            currentChannel = TVChannel.allCases[index]
        }
    }
}

let myTVSet: TVSet = TVSet.init(property: DeviceProperty(brаnd: "Горизонт", model: "61тц305"))

// начальное состояние
print(myTVSet.getCurrentChenalInfo())

//пытаемся включить
myTVSet.pressButton(on: .powerOnOff)
print(myTVSet.getCurrentChenalInfo())

//переключаем канал
myTVSet.pressButton(on: .channelUp)
print(myTVSet.getCurrentChenalInfo())

//переключаем канал
myTVSet.pressButton(on: .channelUp)
print(myTVSet.getCurrentChenalInfo())

//переключаем канал
myTVSet.pressButton(on: .channel_6)
print(myTVSet.getCurrentChenalInfo())

//переключаем канал
myTVSet.pressButton(on: .channelUp)
print(myTVSet.getCurrentChenalInfo())

//переключаем канал
myTVSet.pressButton(on: .channelDown)
print(myTVSet.getCurrentChenalInfo())

//пытаемся выключить
myTVSet.pressButton(on: .powerOnOff)
print(myTVSet.getCurrentChenalInfo())

print("------------------")

// Задача 2
// ----------------
/*
 Время идет, рынок и потребители развиваются, и ваша компания набирает ритм.
 Поступают все новые и новые требования к эволюции устройств. Перед вами снова
 инженерная задача — обеспечить пользователей практичным устройством.

 Алгоритм выполнения
 1. Создайте новый класс Телевизор (с другим названием класса), который будет уметь все, что и предыдущий.

 2. Реализуйте структуру настроек:

   - громкость от 0 до 1 (подумайте, какой тип использовать); показывать цветом или черно-белым (подумайте, какой тип данных лучше всего
 использовать).

   - Интегрируйте Настройки в новый класс Телевизор.

 3. Вызовите метод и покажите, что сейчас идет по телевизору, учитывая настройки.
 */
enum ColorSet {
    case colorRGB
    case colorBW
}

class TVSet2: TVSet {
    var volume: Float = 0
    var color: ColorSet = .colorRGB
    override init(property: DeviceProperty) {
        super.init(property: property)
    }
    
    override func getCurrentChenalInfo() -> String {
        return  "\(super.getCurrentChenalInfo()) | Volume:\(volume) Color:\(color)"
    }
    
    override func pressButton(on button: RemoteButton) {
        switch button {
        case .volumelUp:
            changeValume(direction: .up)
        case .volumeDown:
            changeValume(direction: .down)
        case .colorSwitch:
            colorSwitch()
        default:
            super.pressButton(on: button)
        }
    }
    
    private func changeValume(direction: ButtonUpDown) -> Void {
        volume += 0.1*Float(direction.rawValue)
        if volume > 1 {
                volume = 1
        } else if volume < 0 {
                volume = 0
        }
    }
    
    private func colorSwitch() -> ColorSet {
        switch color {
        case .colorBW:
            color = .colorRGB
        default:
            color = .colorBW
        }
        return color
    }

}

let myTVSet2: TVSet2 = TVSet2.init(property: DeviceProperty(brаnd: "Горизонт", model: "72тц901"))

// начальное состояние
print(myTVSet2.getCurrentChenalInfo())

//пытаемся включить
myTVSet2.pressButton(on: .powerOnOff)
print(myTVSet2.getCurrentChenalInfo())

//переключаем канал
myTVSet2.pressButton(on: .channelUp)
print(myTVSet2.getCurrentChenalInfo())

//добавим громкость
myTVSet2.pressButton(on: .volumelUp)
myTVSet2.pressButton(on: .volumelUp)
myTVSet2.pressButton(on: .volumelUp)
print(myTVSet2.getCurrentChenalInfo())

//изменим цвет
myTVSet2.pressButton(on: .colorSwitch)
print(myTVSet2.getCurrentChenalInfo())
print("------------------")


// Задача 3
// ----------------
/*
 Порог новой эры пройден. Теперь не только есть радиоволна, но и видеомагнитофоны.
 Эту технику подключают проводами к телевизору и смотрят в записи свои любимые фильмы.
 Вам, как ведущему инженеру, срочно нужно адаптировать продукт вашей компании,
 потому как спрос на устаревший вариант резко пошел вниз.

 Алгоритм выполнения
 1. Создайте перечисление со связанными значениями с двумя кейсами: телеканал и подключение по входящему видео порту;
 2. Интегрируйте эту опцию в Телевизор.
 3. Вызовите метод и покажите, что сейчас по телевизору.
 */

enum SourceSignal {
    case tv(name: String)
    case video(name: String)
}

class TVSet3: TVSet2 {
    var source: SourceSignal = .tv(name: "Телевизор")
    override init(property: DeviceProperty) {
        super.init(property: property)
    }
    
    override func getCurrentChenalInfo() -> String {
        return  "\(super.getCurrentChenalInfo()) | Volume:\(volume) Color:\(color) Source:\(source)"
    }
    
    override func pressButton(on button: RemoteButton) {
        switch button {
        case .sourceSwitch:
            sourceSwitch()
        default:
            super.pressButton(on: button)
        }
    }
    
    private func sourceSwitch() -> Void {
        switch source {
        case .tv:
            source = .video(name: "Видеомагнитофон")
        case .video:
            source = .tv(name: "Телевизор")
        }
    }

}

let myTVSet3: TVSet3 = TVSet3.init(property: DeviceProperty(brаnd: "Горизонт", model: "98тц777"))
// начальное состояние
print(myTVSet3.getCurrentChenalInfo())

//пытаемся включить
myTVSet3.pressButton(on: .powerOnOff)
print(myTVSet2.getCurrentChenalInfo())

//переключаем канал
myTVSet3.pressButton(on: .sourceSwitch)
print(myTVSet2.getCurrentChenalInfo())
