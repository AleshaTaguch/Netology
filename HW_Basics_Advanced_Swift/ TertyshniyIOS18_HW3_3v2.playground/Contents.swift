import UIKit

// Задача 1 часть 1
// ----------------

protocol CarProtocol {
    var model: String   { get }              //марка
    var color: String   { get }              //цвет
    var buildDate: String { get }            //дата выпуска
    var price: Double   { get set }          //цена авто
    var accessories: [String] { get set } //дополнительное оборудование (тонировка, сингнализация, спортивные диски)
    var isServiced: Bool { get set }         //сделана ли предпродажная подготовка. Делают в дилерских центрах перед отправкой в салон
}

// Задача 1 часть 2
// ----------------

protocol DealershipProtocol {
    var name: String  { get }                   //название дилерского центра (назвать по марке машины для упрощения)
    var showroomCapacity: Int {get}            //максимальная вместимость автосалона по количеству машин.
    var stockCars: [CarProtocol] { get set }    //машины, находящиеся на парковке склада (парковка не имеет лимита)
    var showroomCars: [CarProtocol] { get set } //машины, находящиеся в автосалоне.
    var cars: [CarProtocol]  { get set }        //массив хранит список всех машин в наличии.

    //Метод предлагает клиенту купить доп. оборудование. Принимает массив акксесуаров в качестве параметра.
    func offerAccesories(accessories: [String], marketingCondition: (String) -> Bool) -> [String]
    
    //Метод отправляет машину на предпродажную подготовку. Принимает машину в качестве параметра.
    func presaleService(car: CarProtocol) -> Int?
    
    //Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.Также принимает машину в качестве параметра.
    func addToShowroom(car: CarProtocol) throws -> Void
    
    //также принимает машину в качестве параметра. Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка. Также, если у машины отсутсвует доп. оборудование, нужно предложить клиенту его купить. (давайте представим, что клиент всегда соглашается и покупает :) )
    func sellCar(car:  CarProtocol) -> Void
    
    //не принимает и не возвращает параметры. Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() -> Void
}

//
enum DealershipError: Error {
    case showroomFull(msg: String)
    case carAlreadyInShowroom(msg:String)
    case carNotFound(msg: String)
}


// диллерский центр
class Dealership: DealershipProtocol {
    var name: String
    let slogan: String
    var showroomCapacity: Int
    
    var stockCars: [CarProtocol]
    var showroomCars: [CarProtocol]
    
    var cars: [CarProtocol]
    
    //каталог доступных в салоне автомобилей и аксесуаров
    let carsCatalog: [CarProtocol]
    let accessoriesCatalog: [String]
    
    init(name: String, showroomCapacity: Int, carsCatalog: [CarProtocol], accessoriesCatalog: [String], slogan: String) {
        self.name = name
        self.showroomCapacity = showroomCapacity
        self.stockCars = []
        self.showroomCars = []
        self.cars = []
        self.carsCatalog = carsCatalog
        self.accessoriesCatalog = accessoriesCatalog
        self.slogan = slogan
        print("Создан магазин \(name) дилера \(type(of: self))")
    }
    
    // ищем машину на парковке
    private func findCarInStock(where car: CarProtocol) -> Int? {
        return stockCars.firstIndex(where: {$0.model == car.model &&
                                        $0.color == car.color &&
                                        $0.buildDate == car.buildDate})
    }
    // ищем машину в салоне
    private func findCarInShowroom(where car: CarProtocol) -> Int? {
        return showroomCars.firstIndex(where: {$0.model == car.model &&
                                               $0.color == car.color &&
                                               $0.buildDate == car.buildDate})
    }
    
    //предлагает клиенту купить доп. оборудование
    func offerAccesories(accessories: [String], marketingCondition: (String) -> Bool ) -> [String] {
        let offer = accessories.filter({marketingCondition($0)})
        print("  Сформирован оффер по покупке доп оборудования: ")
        offer.forEach({print("    - \($0)")})
        return offer
    }
    
    //отправляет машину на предпродажную подготовку
    func presaleService(car: CarProtocol) -> Int? {
        print("Выполянем поиск машины на парковке: \(car)")
        guard let index = findCarInStock(where: car) else {
            print("  - нет такой машины на парковке")
            return nil
        }
        print("  - найдена машина под номером \(index): \(stockCars[index])")
        if !stockCars[index].isServiced {
            stockCars[index].isServiced = true
            print("  - выполнена предпроджажная подготовка")
        }
        return index
    }
    
    //перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
    func addToShowroom(car: CarProtocol) throws {
        guard showroomCars.count-1 < showroomCapacity else {
            throw DealershipError.showroomFull(msg: "Шоурум салона полон. Доставка машин в салон не возможна")
        }
        guard let index = presaleService(car: car) else {
            throw DealershipError.showroomFull(msg: "Машина не найдена при выполнении препродажной подготовки: \(car)")
        }
        if let indexShowRoom = findCarInShowroom(where: car) {
            throw DealershipError.carAlreadyInShowroom(msg: "Машина c такими данными уже есть в автосалоне: \(showroomCars[indexShowRoom])")
        }
        //перемещаем машину в салон
        let removedCar = stockCars.remove(at: index)
        showroomCars.append(removedCar)
        print("Машина перемещена с парковки в автосалон \(removedCar)")
    }
    
    // продает машину из автосалона, проверяет предпродажную подготовку, предлогает клиенту купить доп оборудование
    func sellCar(car: CarProtocol) {
        print("Выполянем поиск машины в салоне для продажи: \(car)")
        guard let index = findCarInShowroom(where: car) else {
            print("  - нет такой машины в салоне")
            return
        }
        guard showroomCars[index].isServiced else {
            print("  - не выполнена предпродажная подготовка, продажа не возможна")
            return
        }
        if showroomCars[index].accessories.isEmpty {
            print("  - машина без доп оборудования. Готовим оффер ....")
            showroomCars[index].accessories = offerAccesories(accessories: accessoriesCatalog ,
                                                              marketingCondition: {Bool.random() && $0.count>0})
            print("  - доп оборудование устанвлено на машину")
        }
        let removedCar = showroomCars.remove(at: index)
        print("  - машина продана  \(removedCar)")
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        print("Заказываем новую машину на заводе ... ")
        var newCar: CarProtocol = carsCatalog[Int.random(in: carsCatalog.startIndex..<carsCatalog.endIndex )]
        newCar.isServiced = false
        newCar.price = newCar.price * Double.random(in:0.8...1.2)
        newCar.accessories = []
        print("... и добавляем машину парковку \(newCar)")
        stockCars.append(newCar)
    }
}

// Задача 1 часть 3
// ----------------

// Автомобили BMW
struct CarBMW_x1: CarProtocol {
    var model: String = "bmw x1"
    var color: String = "black"
    var buildDate: String = "2020"
    var price: Double = 3500000
    var accessories: [String] = ["Бокс на крышу", "Сигнализация"]
    var isServiced: Bool = false
}
struct CarBMW_x3: CarProtocol {
    var model: String = "bmw x3"
    var color: String = "white"
    var buildDate: String = "2020"
    var price: Double = 4500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}
struct CarBMW_x5: CarProtocol {
    var model: String = "bmw x5"
    var color: String = "gold"
    var buildDate: String = "2021"
    var price: Double = 4500000
    var accessories: [String] =  ["Защита двигателя", "Зимние шины"]
    var isServiced: Bool = false
}

// Автомобили AUDI
struct CarAudi_q3: CarProtocol {
    var model: String = "Audi_q3"
    var color: String = "black"
    var buildDate: String = "2020"
    var price: Double = 3500000
    var accessories: [String] = ["Бокс на крышу", "Сигнализация"]
    var isServiced: Bool = false
}
struct CarAudi_q5: CarProtocol {
    var model: String = "Audi_q5"
    var color: String = "white"
    var buildDate: String = "2020"
    var price: Double = 4500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}
struct CarAudi_q7: CarProtocol {
    var model: String = "Audi_q7"
    var color: String = "gold"
    var buildDate: String = "2021"
    var price: Double = 4500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}

// Автомобили Honda
struct CarHonda_CRV: CarProtocol {
    var model: String = "Honda_CRV"
    var color: String = "black"
    var buildDate: String = "2021"
    var price: Double = 3500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}

// Автомобили Lexus
struct CarLexus_LX570: CarProtocol {
    var model: String = "Lexux_LX570"
    var color: String = "black"
    var buildDate: String = "2021"
    var price: Double = 3500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}

// Автомобили Volvo
struct CarVolvo_S80: CarProtocol {
    var model: String = "Vovlo S80"
    var color: String = "black"
    var buildDate: String = "2021"
    var price: Double = 3500000
    var accessories: [String] =  ["Зимние шины", "Автохолодильник"]
    var isServiced: Bool = false
}

//Дилирские центры для разных брендов
class DealershipBMW:   Dealership { }
class DealershipAudi:  Dealership { }
class DealershipHonda: Dealership { }
class DealershipLexus: Dealership { }
class DealershipVolvo: Dealership { }

// Каталог аксесуаров
let accessoriesCatalog: [String] = ["Бокс на крышу"
                                   ,"Сигнализация"
                                   ,"Зимние шины"
                                   ,"Автохолодильник"
                                   ,"Защита двигателя"
                                   ,"Прицепное устройство"
                                   ,"Чехлы"
                                   ,"Коврики"]

// Каталог машин
let carsBMWCatalog: [CarProtocol] = [CarBMW_x1(),CarBMW_x3(),CarBMW_x5()]
let carsAudiCatalog: [CarProtocol] = [CarAudi_q3(),CarAudi_q5(),CarAudi_q7()]
let carsHondaCatalog: [CarProtocol] = [CarHonda_CRV()]
let carsLexusCatalog: [CarProtocol] = [CarLexus_LX570()]
let carsVolvoCatalog: [CarProtocol] = [CarVolvo_S80()]


let shopBMW:   DealershipBMW   = DealershipBMW  (name: "BMW Shop",
                                                 showroomCapacity: 3,
                                                 carsCatalog: carsBMWCatalog,
                                                 accessoriesCatalog: accessoriesCatalog,
                                                 slogan: "С удовольствием за рулем»")
let shopAudi:  DealershipAudi  = DealershipAudi (name: "Audi Shop" ,
                                                 showroomCapacity: 5,
                                                 carsCatalog: carsHondaCatalog,
                                                 accessoriesCatalog: accessoriesCatalog,
                                                 slogan: "Техническое превосходство")
let shopHonda: DealershipHonda = DealershipHonda(name: "Honda Shop",
                                                 showroomCapacity: 4,
                                                 carsCatalog: carsAudiCatalog,
                                                 accessoriesCatalog: accessoriesCatalog,
                                                 slogan: "Honda. The Power of Dreams")
let shopLexus: DealershipLexus = DealershipLexus(name: "Lexus Shop",
                                                 showroomCapacity: 3,
                                                 carsCatalog: carsLexusCatalog,
                                                 accessoriesCatalog: accessoriesCatalog,
                                                 slogan: "Неудержимое стремление к совершенству")
let shopVolvo: DealershipVolvo = DealershipVolvo(name: "Volvo Shop",
                                                 showroomCapacity: 2,
                                                 carsCatalog: carsLexusCatalog,
                                                 accessoriesCatalog: accessoriesCatalog,
                                                 slogan: "Вольво для жизни")

let arrayDealership: [Dealership] = [shopBMW,shopHonda,shopAudi,shopLexus,shopVolvo]

for dealer in arrayDealership {
    print("\n----------------------------")
    print(dealer.name)
    for _ in 1...3 { dealer.orderCar() }
    switch dealer {
    case let ds as DealershipBMW:
        do {
            try ds.addToShowroom(car: CarBMW_x3())
        } catch {
            print("! Ошибка: \(error).")
        }
        ds.sellCar(car: CarBMW_x3())
        print("Слоган: \(ds.slogan)")
    case let ds as DealershipAudi:
        do {
            try ds.addToShowroom(car: CarAudi_q3())
        } catch {
            print("! Ошибка: \(error).")
        }
        ds.sellCar(car: CarAudi_q3())
        print("Слоган: \(ds.slogan)")
    case let ds as DealershipHonda:
        do {
            try ds.addToShowroom(car: CarHonda_CRV())
        } catch {
            print("! Ошибка: \(error).")
        }
        ds.sellCar(car: CarHonda_CRV())
        print("Слоган: \(ds.slogan)")
    case let ds as DealershipLexus:
        do {
            try ds.addToShowroom(car: CarLexus_LX570())
        } catch {
            print("! Ошибка: \(error).")
        }
        ds.sellCar(car: CarLexus_LX570())
        print("Слоган: \(ds.slogan)")
    case let ds as DealershipVolvo:
        do {
            try ds.addToShowroom(car: CarVolvo_S80())
        } catch {
            print("! Ошибка: \(error).")
        }
        ds.sellCar(car: CarVolvo_S80())
        print("Слоган: \(ds.slogan)")
    default:
        print("Не ивестны тип диллерского центра")
    }
}


// Задача 4
// ----------------

protocol SpecialOffer {
    //добавляет аптечку и огнетушитель к доп. оборудованию машины.
    func addEmergencyPack()
    //Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего,
    //нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
    func makeSpecialOffer()
}


enum SpecialOfferError: Error {
    case conditionNotMet(msg: String)
    case emergencyAccessoryAlreadyExist(msg: String)
}

extension Dealership: SpecialOffer {

    
   private func accEmergencyAccessory(to car: inout CarProtocol) throws {
        let accessoriesEmergencyPack: [String] = ["Огнетушитель", "Аптечка"]
        for accessory in accessoriesEmergencyPack {
            if let _ = car.accessories.firstIndex(of: accessory) {
                throw SpecialOfferError.emergencyAccessoryAlreadyExist(msg: "Доп оборудование \(accessory) уже есть автомобиля \(car)")
            } else {
                car.accessories.append(accessory)
                print("Добавлено доп оборудование \(accessory) в автомобиля \(car)")
            }
        }
    }
    
    private func makeSpecialOfferToCar(to car: inout CarProtocol) throws {
        let currateYear: String = "2021"
        guard car.buildDate < currateYear else {
            throw SpecialOfferError.conditionNotMet(msg: "Не выполнено условие buildDate<currateYear: \(car.buildDate) < \(currateYear)" )
        }
        print("Машина подходит под спец предложению: \(car)")
        do {
            try accEmergencyAccessory(to: &car)
            car.price = car.price * 0.75
            print("Машина обновлена по спецпредложению: \(car)")
        } catch {
            throw error
        }

    }
    
    //добавляет аптечку и огнетушитель к доп. оборудованию машины.
    func addEmergencyPack() {
        for indexCar in stockCars.startIndex..<stockCars.endIndex {
            do {
                try accEmergencyAccessory(to: &stockCars[indexCar])
            } catch SpecialOfferError.emergencyAccessoryAlreadyExist(let errorMsg) {
                print("! Внимание. \(errorMsg) для машины: \(stockCars[indexCar])")
            } catch {
                print("! Ошибка: \(error).")
            }
        }
        
    }
    //Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего,
    //нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
    func makeSpecialOffer() {
        //перебираем машины в шоуруме
        for indexCar in showroomCars.startIndex..<showroomCars.endIndex {
            do {
                try makeSpecialOfferToCar(to: &showroomCars[indexCar])
            } catch SpecialOfferError.conditionNotMet(let errorMsg) {
                print("! Внимание. \(errorMsg) для машины: \(stockCars[indexCar])")
            } catch SpecialOfferError.emergencyAccessoryAlreadyExist(let errorMsg) {
                print("! Внимание. \(errorMsg) для машины: \(stockCars[indexCar])")
            } catch {
                print("! Ошибка: \(error).")
            }
        }
        //перебираем машины на парковке
        var indexStockCar: Int = stockCars.startIndex
        while indexStockCar<stockCars.endIndex {
            do {
                try makeSpecialOfferToCar(to: &stockCars[indexStockCar])
                print("Отправляем машину в шоурум: \(stockCars[indexStockCar])")
                do {
                    try addToShowroom(car: stockCars[indexStockCar])
                } catch {
                    print("! Ошибка: \(error).")
                }
            } catch SpecialOfferError.conditionNotMet(let errorMsg) {
                print("! Внимание. \(errorMsg) для машины: \(stockCars[indexStockCar])")
            } catch SpecialOfferError.emergencyAccessoryAlreadyExist(let errorMsg) {
                print("! Внимание. \(errorMsg) для машины: \(stockCars[indexStockCar])")
            } catch {
                print("! Ошибка: \(error).")
            }
            indexStockCar = stockCars.index(after: indexStockCar)
        }
    }
}

// проверяем спецпредложения для всех диллерских центров
for dealer in arrayDealership {
    print("-----------------------------")
    print(dealer.name)
    dealer.makeSpecialOffer()
}
print("-----------------------------")
