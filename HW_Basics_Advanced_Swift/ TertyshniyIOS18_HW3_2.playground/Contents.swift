import UIKit

protocol CarProtocol {
    var model: String   { get }              //марка
    var color: String   { get }              //цвет
    var buildDate: String { get }            //дата выпуска
    var price: Double   { get set }          //цена авто
    var accessories: [String] { get set } //дополнительное оборудование (тонировка, сингнализация, спортивные диски)
    var isServiced: Bool { get set }         //сделана ли предпродажная подготовка. Делают в дилерских центрах перед отправкой в салон
}

protocol DealershipProtocol {
    var name: String  { get }                   //название дилерского центра (назвать по марке машины для упрощения)
    var showroomCapacity: Int {get}            //максимальная вместимость автосалона по количеству машин.
    var stockCars: [CarProtocol] { get set }    //машины, находящиеся на парковке склада (парковка не имеет лимита)
    var showroomCars: [CarProtocol] { get set } //машины, находящиеся в автосалоне.
    var cars: [CarProtocol]  { get set }        //массив хранит список всех машин в наличии.

    //Метод предлагает клиенту купить доп. оборудование. Принимает массив акксесуаров в качестве параметра.
    func offerAccesories(accessories: [String]) -> [String]
    
    //Метод отправляет машину на предпродажную подготовку. Принимает машину в качестве параметра.
    func presaleService(car: CarProtocol) -> Void
    
    //Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.Также принимает машину в качестве параметра.
    func addToShowroom(car: CarProtocol) -> Void
    
    //также принимает машину в качестве параметра. Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка. Также, если у машины отсутсвует доп. оборудование, нужно предложить клиенту его купить. (давайте представим, что клиент всегда соглашается и покупает :) )
    func sellCar(car:  CarProtocol) -> Void
    
    //не принимает и не возвращает параметры. Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() -> Void
}

struct CarBMW: CarProtocol {
    var model: String
    var color: String
    var buildDate: String
    var price: Double
    var accessories: [String]
    var isServiced: Bool
}
struct CarHonda: CarProtocol {
    var model: String
    var color: String
    var buildDate: String
    var price: Double
    var accessories: [String]
    var isServiced: Bool
}
struct CarAudi: CarProtocol {
    var model: String
    var color: String
    var buildDate: String
    var price: Double
    var accessories: [String]
    var isServiced: Bool
}
struct CarLexus: CarProtocol {
    var model: String
    var color: String
    var buildDate: String
    var price: Double
    var accessories: [String]
    var isServiced: Bool
}
struct CarVolvo: CarProtocol {
    var model: String
    var color: String
    var buildDate: String
    var price: Double
    var accessories: [String]
    var isServiced: Bool
}

var myCarBMW1: CarBMW = CarBMW(model: "bmw x1"
                             ,color: "black"
                             ,buildDate: "2021"
                             ,price: 3500000
                             ,accessories: ["Бокс на крышу", "Сигнализация"]
                             ,isServiced: false )
var myCarBMW3: CarBMW = CarBMW(model: "bmw x3"
                             ,color: "black"
                             ,buildDate: "2020"
                             ,price: 4500000
                             ,accessories: ["Зимние шины", "Автохолодильник"]
                             ,isServiced: false )
var myCarBMW5: CarBMW = CarBMW(model: "bmw x5"
                             ,color: "black"
                             ,buildDate: "2020"
                             ,price: 5500000
                             ,accessories: []
                             ,isServiced: false )
var myCarAudi: CarAudi = CarAudi(model: "audi x1"
                                ,color: "black"
                                ,buildDate: "2021"
                                ,price: 3500000
                                ,accessories: ["Защита двигателя", "Зимние шины"]
                                ,isServiced: false )
var myCarVolvo: CarVolvo = CarVolvo(model: "audi x1"
                                   ,color: "black"
                                   ,buildDate: "2021"
                                   ,price: 3500000
                                   ,accessories: ["Сигнализация", "Прицепное устройство"]
                                   ,isServiced: false )

class Dealership: DealershipProtocol {
    var name: String
    var showroomCapacity: Int
    
    var stockCars: [CarProtocol]
    var showroomCars: [CarProtocol]
    var cars: [CarProtocol]
    
    let accessoriesCatalog: [String]
    
    init(name: String,showroomCapacity: Int, accessoriesCatalog: [String]) {
        self.name = name
        self.showroomCapacity = showroomCapacity
        self.stockCars = []
        self.showroomCars = []
        self.cars = []
        self.accessoriesCatalog = accessoriesCatalog
    }
    
    //предлагает клиенту купить доп. оборудование
    func offerAccesories(accessories: [String]) -> [String] {
        let offer = accessories.filter({Bool.random() && $0.count>0})
        print("  Оффер по покупке доп оборудования: ")
        offer.forEach({print("    - \($0)")})
        return offer
    }
    
    //отправляет машину на предпродажную подготовку
    func presaleService(car: CarProtocol) {
        print("*** presaleService ***")
        var newCar: CarProtocol
        print("Выполянем поиск машины на парковке: \(car)")
        if let index = stockCars.firstIndex(where: {$0.model == car.model && $0.color == car.color && $0.buildDate == car.buildDate}) {
            print("  - найдена машина под номером \(index): \(stockCars[index])")
            if !stockCars[index].isServiced {
                stockCars[index].isServiced = true
                print("  - выполнена предпроджажная подготовка")
            }
        } else {
            print("  - нет такой машины на парковке")
            newCar = car
            if !newCar.isServiced {
                newCar.isServiced = true
                print("  - выполнена предпроджажная подготовка")
            }
            stockCars.append(newCar)
            print("  - машина доставлена на парковку")
        }
        return
    }
    
    //перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
    func addToShowroom(car: CarProtocol) {
        var newCar: CarProtocol
        print("*** addToShowroom ***")
        if showroomCars.count-1 >= showroomCapacity {
            print("Шоурум салона полон. Доставка машин в салон не возможна")
            
        } else {
            print("Выполянем поиск машины на парковке: \(car)")
            if let index = stockCars.firstIndex(where: {$0.model == car.model && $0.color == car.color && $0.buildDate == car.buildDate}) {
                print("  - найдена машина под номером \(index): \(stockCars[index])")
                if !stockCars[index].isServiced {
                    stockCars[index].isServiced = true
                    print("  - выполнена предпроджажная подготовка")
                }
                showroomCars.append(stockCars[index])
                stockCars.remove(at: index)
                print("  - машина перемещена с парковки в автосалон")
            } else {
                print("  - нет такой машины на парковке")
                newCar = car
                if !newCar.isServiced {
                    newCar.isServiced = true
                    print("  - выполнена предпроджажная подготовка")
                }
                showroomCars.append(newCar)
                print("  - машина доставлена в атосалон")
            }
        }
    }
    
    // продает машину из автосалона, проверяет предпродажную подготовку, предлогает клиенту купить доп оборудование
    func sellCar(car: CarProtocol) {
        print("*** sellCar ***")
        print("Выполянем поиск машины в салоне: \(car)")
        if let index = showroomCars.firstIndex(where: {$0.model == car.model && $0.color == car.color && $0.buildDate == car.buildDate}) {
            print("  - найдена машина под номером \(index): \(showroomCars[index])")
            if !showroomCars[index].isServiced {
                showroomCars[index].isServiced = true
                print("  - выполнена предпроджажная подготовка")
            } else {
                print("  - машина с предпроджажной подготовкой")
            }
            if showroomCars[index].accessories.isEmpty {
                print("  - машина без доп оборудования. Готовим оффер ....")
                showroomCars[index].accessories = offerAccesories(accessories: accessoriesCatalog)
                print("  - доп оборудование устанвлено на машину")
            }
            showroomCars.remove(at: index)
            print("  - машина продана")
        } else {
            print("  - нет такой машины в салоне")
        }
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        switch self {
        case is DealershipBMW:
            print("Заказываем BMW и добавляем машину парковку")
            stockCars.append(CarBMW(model: "bmw x1"
                                    ,color: "black"
                                    ,buildDate: "2021"
                                    ,price: 3500000
                                    ,accessories: ["Чехлы", "Автохолодильник"]
                                    ,isServiced: false ))
        case is DealershipHonda:
            print("Заказываем Honda и добавляем машину парковку")
            stockCars.append(CarHonda(model: "Honda"
                                    ,color: "black"
                                    ,buildDate: "2021"
                                    ,price: 3500000
                                    ,accessories: ["Чехлы", "Автохолодильник"]
                                    ,isServiced: false ))
        case is DealershipAudi:
            print("Заказываем Audi и добавляем машину парковку")
            stockCars.append(CarBMW(model: "Audi"
                                    ,color: "black"
                                    ,buildDate: "2021"
                                    ,price: 3500000
                                    ,accessories: ["Чехлы", "Автохолодильник"]
                                    ,isServiced: false ))
        case is DealershipLexus:
            print("Заказываем Lexus и добавляем машину парковку")
            stockCars.append(CarLexus(model: "Lexus"
                                    ,color: "black"
                                    ,buildDate: "2021"
                                    ,price: 3500000
                                    ,accessories: ["Чехлы", "Автохолодильник"]
                                    ,isServiced: false ))
        case is DealershipVolvo:
            print("Заказываем Volvo и добавляем машину парковку")
            stockCars.append(CarVolvo(model: "Volvo"
                                    ,color: "black"
                                    ,buildDate: "2021"
                                    ,price: 3500000
                                    ,accessories: ["Чехлы", "Автохолодильник"]
                                    ,isServiced: false ))
        default:
            print("Не ивестны тип диллерского центра")
        }
    }

}

let accessoriesCatalog: [String] = ["Бокс на крышу"
                                   ,"Сигнализация"
                                   ,"Зимние шины"
                                   ,"Автохолодильник"
                                   ,"Защита двигателя"
                                   ,"Прицепное устройство"
                                   ,"Чехлы"
                                   ,"Коврики"]

class DealershipBMW:   Dealership { }
class DealershipHonda: Dealership { }
class DealershipAudi:  Dealership { }
class DealershipLexus: Dealership { }
class DealershipVolvo: Dealership { }

let shopBMW:   DealershipBMW   = DealershipBMW  (name: "BMW Shop"  ,showroomCapacity: 3, accessoriesCatalog: accessoriesCatalog)
let shopHonda: DealershipHonda = DealershipHonda(name: "Honda Shop",showroomCapacity: 4, accessoriesCatalog: accessoriesCatalog)
let shopAudi:  DealershipAudi  = DealershipAudi (name: "Audi Shop" ,showroomCapacity: 5, accessoriesCatalog: accessoriesCatalog)
let shopLexus: DealershipLexus = DealershipLexus(name: "Lexus Shop",showroomCapacity: 3, accessoriesCatalog: accessoriesCatalog)
let shopVolvo: DealershipVolvo = DealershipVolvo(name: "Volvo Shop",showroomCapacity: 2, accessoriesCatalog: accessoriesCatalog)

print(shopBMW.name)
shopBMW.orderCar()
shopBMW.addToShowroom(car: myCarBMW1)
shopBMW.presaleService(car: myCarBMW3)
shopBMW.sellCar(car: myCarBMW1)
shopBMW.addToShowroom(car: myCarBMW5)
shopBMW.sellCar(car: myCarBMW5)

print(shopLexus.name)
shopLexus.orderCar()

print("-----------------------------")
let arrayDealership: [DealershipProtocol] = [shopBMW,shopHonda,shopAudi,shopLexus,shopVolvo]
for dealer in arrayDealership {
    switch dealer {
    case is DealershipBMW:
        print("Слоган BMW: С удовольствием за рулем»")
    case is DealershipHonda:
        print("Слоган Honda: Honda. The Power of Dreams")
    case is DealershipAudi:
        print("Слоган Audi: Nехническое превосходство")
    case is DealershipLexus:
        print("Слоган Lexus: Неудержимое стремление к совершенству")
    case is DealershipVolvo:
        print("Слоган Volvo: Вольво для жизни")
    default:
        print("Не ивестны тип диллерского центра")
    }
}

print("-----------------------------")

// Задача 4
// ----------------

protocol SpecialOffer {
    //добавляет аптечку и огнетушитель к доп. оборудованию машины.
    func addEmergencyPack()
    //Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего,
    //нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
    func makeSpecialOffer()
}

extension Dealership: SpecialOffer {
    
   private func accEmergencyAccessory(to car: inout CarProtocol) {
        let accessoriesEmergencyPack: [String] = ["Огнетушитель", "Аптечка"]
        for accessory in accessoriesEmergencyPack {
            if let _ = car.accessories.firstIndex(of: accessory) {
                print("Доп оборудование \(accessory) уже есть автомобиля \(car)")
            } else {
                car.accessories.append(accessory)
                print("Добавлено доп оборудование \(accessory) в автомобиля \(car)")
            }
        }
    }
    
    private func makeSpecialOfferToCar(to car: inout CarProtocol) {
        let currateYear: String = "2021"
        if car.buildDate < currateYear {
            print("Машина подходит под спец предложению: \(car)")
            car.price = car.price * 0.75
            accEmergencyAccessory(to: &car)
            print("Машина обновлена по спецпредложению: \(car)")
        }
        
    }
    
    //добавляет аптечку и огнетушитель к доп. оборудованию машины.
    func addEmergencyPack() {
        for indexCar in stockCars.startIndex..<stockCars.endIndex {
            accEmergencyAccessory(to: &stockCars[indexCar])
        }
        
    }
    //Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего,
    //нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
    func makeSpecialOffer() {
        for indexCar in stockCars.startIndex..<stockCars.endIndex {
            accEmergencyAccessory(to: &stockCars[indexCar])
        }
        for indexCar in showroomCars.startIndex..<showroomCars.endIndex {
            accEmergencyAccessory(to: &showroomCars[indexCar])
        }
    }
}

shopBMW.makeSpecialOffer()
shopHonda.makeSpecialOffer()
shopAudi.makeSpecialOffer()

print("----------------")
