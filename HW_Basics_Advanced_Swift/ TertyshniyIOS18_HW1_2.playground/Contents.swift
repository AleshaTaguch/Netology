import UIKit

// Задача 1
// ----------------
/*
 Придумайте именованные типы Swift, подбирая лучшие абстракции.
 Объявите свойства и методы в них. Статический анализатор подскажет,
 если вы забудете кое-что ('Type annotation missing...').
 На предупреждения о том, что в enum нельзя объявлять хранимые свойства
 и на необходимость инициализаторов в class, пока не обращайте внимания.
 
 enum, struct, class
*/

enum  SatusUserAccount{
    case open
    case blocked
    case close
    case erased
}

struct UserAccount {
    let id: UInt
    var nickname: String
    var fio: String
    var status: SatusUserAccount
}

var userAccountOne: UserAccount
var userAccountList: [UserAccount] = []

userAccountOne = UserAccount(id: 123, nickname: "firstman", fio: "armstrong nill", status: SatusUserAccount.open)

userAccountList.append(UserAccount(id: 22334455, nickname: "flydubay", fio: "nilson duck", status: SatusUserAccount.open))
userAccountList.append(UserAccount(id: 23443215, nickname: "mrdiner", fio: "duglas stik", status: SatusUserAccount.blocked))
userAccountList.append(UserAccount(id: 55448761, nickname: "superdeger", fio: "ivanov peter", status: SatusUserAccount.close))
userAccountList.append(userAccountOne)

userAccountList.forEach { row in print(row) }
    
//-----------------


enum  SatusCard{
    case making
    case open
    case lost
    case close
}

enum  OperationType: Int{
    case debit = -1
    case credit = 1
}

struct PayCard {
    let ID: UInt
    var panWraped: String
    var status: SatusCard
    var desing: String
    var balance: Double = 0
    mutating func recalcBalance(sumOper: Double, operType: OperationType) ->Void {
        balance += sumOper * Double(operType.rawValue)
    }
}

var myBackCard: PayCard
myBackCard = PayCard(ID: 1234567, panWraped: "1234***0987", status: SatusCard.open, desing: "VisaGold")

print (myBackCard.balance)
myBackCard.recalcBalance(sumOper: 1000, operType: OperationType.credit)
print (myBackCard.balance)


//-----------------

enum  Sex: String{
    case male   = "М"
    case female = "Ж"
}

enum  TypeDay {
    case working
    case noworking
    case holiday
}

struct PersonalInfo {
    let fio: String
    let age: Int
    let sex: Sex
}

class Employee {
    let personalInfo:PersonalInfo
    private var workingHours: Float
    private var weekendHours: Int
    func getRateDay(_ day : TypeDay) -> Float {
        switch day {
        case .noworking:
            return  2.0
        case .holiday:
            return 2.5
        default:
            return 1
        }
    }
    func addWorkingHours(value: Float, day: TypeDay) -> Void {
        self.workingHours += value * getRateDay(day)
        self.weekendHours = Int(weekendHours/40)*8
    }
    func getHours() -> (workingHours: Float,weekendHours: Int) {
        return (self.workingHours,self.weekendHours)
    }
    func clearWorkHours() -> Void {
        self.workingHours = 0
        self.weekendHours = 0
    }
    init(_ personalInfo:PersonalInfo) {
        self.personalInfo = personalInfo
        self.workingHours = 0
        self.weekendHours = 0
    }
}

class WorkGroup {
    var name: String
    var members: [Employee]
    init(name: String) {
        self.name = name
        members = []
    }
}

class StudyWorkGroup: WorkGroup  {
    var teacher: Employee
    init(name: String, teacher: PersonalInfo) {
        self.teacher = Employee(teacher)
        super.init(name: name)
    }
}

let fice1: Employee = Employee.init(PersonalInfo(fio: "vito corleone", age: 63, sex: .male))
let fice2: Employee = Employee.init(PersonalInfo(fio: "carmella corleone", age: 58, sex: .female))
let fice3: Employee = Employee.init(PersonalInfo(fio: "fredo corleone", age: 36, sex: .male))


let gangsterWorkGroup: WorkGroup = WorkGroup.init(name:"done corleone family")
gangsterWorkGroup.members = [fice1,fice2,fice3]

let gangsterStudyGroup: StudyWorkGroup = StudyWorkGroup.init(name:"done corleone family", teacher: PersonalInfo(fio: "mark makklacky", age: 47, sex: .male))
gangsterStudyGroup.members = [fice1,fice3]

// Задача 2
// ----------------
/*
 Напишите по 2 примера композиции и агрегации из реального мира, без использования кода.
 Каждому примеру дайте объяснения почему это композиция или агрегация.
 */

/*
 В приведеном выше примере:
   - класс WorkGroup содержит агрегацию объектов класса Employee потому, что сотрудники (Employee)
     существуют отдельно от группы, в которую они объеденены. Они создаются и удаляются отдельно друг от друга.
   - класс StudyWorkGroup содержит композицию класса Employee и StudyWorkGroup потому, что объект учитель (teacher)
     создается при создании объекта класса StudyWorkGroup и не существует отдельно от него.
 
 Еще примеры:
 
 Корзина покупок состоящая из товаров — агрегация. Товары существуют отдельно от корзины и могут меняться самостоятельно
 
 Комментарии в ленте отзывов к товару — это композиция. Комментарии кринадлежат только данному товару
 и существуют только при наличии товара
 
 */
