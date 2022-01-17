import UIKit

// Задача 1 и 2
// ----------------
/*
 Задача 1
 Возьмите любой пример из жизни (класс) и опишите уровни доступа к нему.
 Постарайтесь описать как публичные,, так и закрытые уровни и методы.
 Для решения задачи можно взять класс из предыдущего домашнего задания.

 Пример:
 Класс: такси

 Имеет публичный доступ, так как любой может воспользоваться отдельным экземпляром (объектом) такси.
 Пример геттера: узнать цену поездки
 Пример сеттера: установить конечную точку маршрута
 Пример публичного метода: заказать такси к определенному месту
 Пример приватного метода: доехать до клиента

 Задача 2
 Создайте класс.
 Создайте 3 метода с одинаковым названием, но разными сигнатурами.
 Статический анализатор Swift подскажет вам, если overload не получится ;)
 
*/

let defaultCountCassetes: Int = 4;

enum StatusType {
    case enable
    case disable
    case fail
}

struct ATMCasseta {
    var countBill: UInt
    var denamination: UInt
    var countError: Int
    var status: StatusType
}

class ATMDispenser {
    private var setCassetes: [ATMCasseta]
    private var rejectCassete: ATMCasseta
    
    // остаток
    var remain: UInt {
        get {
            return setCassetes.reduce(into: 0, {res, cassete in res += cassete.countBill * cassete.denamination } )
        }
    }
    
    var countEnableCasset: UInt {
        get {
            return setCassetes.reduce(into: 0, {res, cassete in if cassete.status == .enable {res += 1} } )
        }
    }

    var status: StatusType {
        get {
            return setCassetes.reduce(into: StatusType.fail, {res, cassete in
                if cassete.status == .enable {res = .enable}
                else if cassete.status == .disable && res != .enable {res = .disable}
                }
            )
        }
        set(newStatus) {
            if newStatus != .fail {
                for index in setCassetes.startIndex..<setCassetes.endIndex {
                    if setCassetes[index].status != .fail {
                      setCassetes[index].status = newStatus
                    }
                }
            }
        }
    }

    init(countCassetes: Int) {
        self.setCassetes = [ATMCasseta](repeating: ATMCasseta(countBill: 0, denamination: 0, countError:0, status: .enable), count: countCassetes)
        self.rejectCassete = ATMCasseta(countBill: 0, denamination: 0, countError: 0, status: .enable)
    }
    
    convenience init() {
        self.init(countCassetes: defaultCountCassetes)
    }
    
    func setDemoninationCassetesSet(denominationSet: [UInt]) ->Void {
        if !denominationSet.isEmpty {
            for index in setCassetes.startIndex..<setCassetes.endIndex {
                if index >= denominationSet.startIndex && index < denominationSet.endIndex {
                    setCassetes[index].denamination = denominationSet[index]
                }
            }
        }
    }

    //замена касет банкомата - инкассация
    func setCash(cassetes: [ATMCasseta]) ->Void {
        if !cassetes.isEmpty {
            for index in setCassetes.startIndex..<setCassetes.endIndex {
                if index >= cassetes.startIndex && index < cassetes.endIndex {
                    setCassetes[index] = cassetes[index]
                }
            }
        }
    }

    //замена касет банкомата - инкассация
    func setCash(billSet: [UInt]) ->Void {
        if !billSet.isEmpty {
            for index in setCassetes.startIndex..<setCassetes.endIndex {
                if index >= billSet.startIndex && index < billSet.endIndex {
                    setCassetes[index].countBill = billSet[index]
                }
            }
        }
    }

    //замена касет банкомата - инкассация
    func setCash() ->Void {
        for index in setCassetes.startIndex..<setCassetes.endIndex {
            setCassetes[index].countBill = 0
        }
    }

    // выдача купур из касеты. возвращает количество выданных купур
    private func dispenseFromCassete(index: Int, countBill: UInt) -> UInt {
        var countRejectBill: UInt = 0
        var countDispenceBill: UInt = 0
        
        if index >= setCassetes.startIndex && index < setCassetes.endIndex {
            if setCassetes[index].status == .enable {
                //расчет количества имитации забракованных купюр
                countRejectBill = UInt(Int.random(in: 0...Int(Float(countBill)*0.1)))
                //кол-во купур к выдаче
                countDispenceBill = countBill - countRejectBill
                //кол-во выданных купур
                countDispenceBill = min(setCassetes[index].countBill,countDispenceBill)
                setCassetes[index].countBill -= countDispenceBill
                if countRejectBill>0 {
                  setCassetes[index].countError += 1
                }
            }
        }
        return countDispenceBill
    }
    
    // выдача суммы из банкомата
    func dispenseSum(sum: UInt) -> UInt {
        var remainSum: UInt
        var prevRemainSum: UInt
        var countBillForDispance: UInt
    
        remainSum = sum
        prevRemainSum = 0
        while remainSum > 0 && prevRemainSum != remainSum {
            prevRemainSum = remainSum
            for index in setCassetes.startIndex..<setCassetes.endIndex {
                countBillForDispance = UInt(remainSum / setCassetes[index].denamination)
                if countBillForDispance>0 {
                    countBillForDispance = dispenseFromCassete(index: index, countBill: countBillForDispance)
                    remainSum -= countBillForDispance * setCassetes[index].denamination
                    print("*** выдача: |кассета \(index) |номинал \(setCassetes[index].denamination) |купур \(countBillForDispance)")
                }
            }
        }
        return (sum - remainSum)
    }

}
    

let myATMDispenser = ATMDispenser.init()
myATMDispenser.setDemoninationCassetesSet(denominationSet: [50,100,500,1000])
myATMDispenser.setCash(billSet: [10,10,10,10])

print("Остаток: \(myATMDispenser.remain)")
print("Выдал: \(myATMDispenser.dispenseSum(sum: 10000))")
print("Выдал: \(myATMDispenser.dispenseSum(sum: 10000))")
print("Кол-во доступных кассет: \(myATMDispenser.countEnableCasset)")

myATMDispenser.status = .disable
print(myATMDispenser.status)



// Задача 3
// ----------------
/*
Создайте класс-родитель. Определите в нем метод.
Создайте класс-наследник. Переопределите в нем метод родителя, но с вызовом родительского метода.
 */

class ATMDispenser2: ATMDispenser {
    // выдача суммы из банкомата
    override func dispenseSum(sum: UInt) -> UInt {
        if sum >= 1000 && sum <= 150000 {
           return super.dispenseSum(sum: sum)
        } else {
            return 0
        }
    }
}

let myATMDispenser2 = ATMDispenser2.init()
myATMDispenser2.setDemoninationCassetesSet(denominationSet: [100,500,1000,2000])
myATMDispenser2.setCash(billSet: [10,100,100,1000])

print("-----------------------")
print("Остаток: \(myATMDispenser2.remain)")
print("Выдал: \(myATMDispenser2.dispenseSum(sum: 10000))")
print("Выдал: \(myATMDispenser2.dispenseSum(sum: 200000))")

