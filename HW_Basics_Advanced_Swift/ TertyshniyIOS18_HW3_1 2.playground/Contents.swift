import UIKit

// Задача 1
// ----------------
/*
 Вы продолжаете разрабатывать библиотеку аудио треков. Сейчас будем работать над исполнителями треков.

 Алгоритм выполнения
 Создайте суперкласс артист;
 Определите в нем общие для артиста свойства (имя, страна, жанр);
 Определите общие методы (написать трек и исполнить трек);
 В реализацию метода "написать трек" добавьте вывод в консоль "Я (имя артиста) написал трек (название трека)";
 В реализацию метода "исполнить трек" добавьте вывод в консоль "Я (имя артиста) исполнил трек (название трека)";
 Создайте 3 сабкласса любых артистов и переопределите в них свойства суперкласса класса.
*/

class Artist {
    var name: String
    var country: String
    var genry: String
    
    init(name: String, country: String, genry: String) {
        self.name    = name
        self.country = country
        self.genry   = genry
    }
    
    func writeTrack(name trackName: String) -> Void {
        print("Я \(name) написал трек \(trackName)")
    }
    
    func executeTrack(name trackName: String) -> Void {
        print("Я \(name) исполнил трек \(trackName)")
    }
    
}

class ArtistCirqus: Artist {
    var amimals: String
    init(name: String, country: String, genry: String, amimals: String) {
        self.amimals = amimals
        super.init(name: name, country: country, genry: genry)
    }
    
    override func executeTrack(name trackName: String) -> Void {
        super.executeTrack(name: trackName)
        print("вместе с востипанником по имени \(amimals)")
        
    }
}

class ArtistPhilharmonic: Artist {
    var musicalInstrument: String
    init(name: String, country: String, genry: String, musicalInstrument: String) {
        self.musicalInstrument = musicalInstrument
        super.init(name: name, country: country, genry: genry)
    }
    
    override func executeTrack(name trackName: String) -> Void {
        super.executeTrack(name: trackName)
        print("на инструменте \(musicalInstrument)")
        
    }
}

class ArtistOpera: Artist {
    var voiceLevel: String
    init(name: String, country: String, genry: String, voiceLevel: String) {
        self.voiceLevel = voiceLevel
        super.init(name: name, country: country, genry: genry)
    }
    override func executeTrack(name trackName: String) -> Void {
        super.executeTrack(name: trackName)
        print("своим замечательным голосом \(voiceLevel)")
        
    }
}

let atrist1: ArtistCirqus = ArtistCirqus(name: "Запашный"
                                        ,country: "РФ"
                                        ,genry: "опасный"
                                        ,amimals: "Тигр")
atrist1.executeTrack(name: "Новогодний привет")


let atrist2: ArtistPhilharmonic = ArtistPhilharmonic(name: "Евгений Дятлов"
                                                    ,country: "РФ"
                                                    ,genry: "романтичный"
                                                    ,musicalInstrument: "Гитара")
atrist2.executeTrack(name: "Новогодний этюд")

let atrist3: ArtistOpera = ArtistOpera(name: "Месняев"
                                      ,country: "РФ"
                                      ,genry: "оперный"
                                      ,voiceLevel: "Бас")
atrist3.executeTrack(name: "Новогодний партия")

// Задача 2
// ----------------
/*
 Создание списка артистов.

 Алгоритм выполнения
 - Доработайте существующих артистов так, чтобы они имели уникальные для каждого из них свойства и методы.
 - Защитите этих артистов от редактирования в будущем.
 */


final class ArtistCirqusAdvanced: ArtistCirqus {
    override init(name: String, country: String, genry: String, amimals: String) {
        super.init(name: name, country: country, genry: genry, amimals: amimals)
    }
    
    func dangerousLevel() -> Void {
        print("Ну очень страшно")
    }
}

final class ArtistPhilharmonicAdvanced: ArtistPhilharmonic {
    override init(name: String, country: String, genry: String, musicalInstrument: String) {
        super.init(name: name, country: country, genry: genry, musicalInstrument: musicalInstrument)
    }
    
    func harmonicSound() -> Void {
        print("Просто космос")
    }
    
}

final class ArtistOperaAdvanced: ArtistOpera {
    override init(name: String, country: String, genry: String, voiceLevel: String) {
        super.init(name: name, country: country, genry: genry,voiceLevel: voiceLevel)
    }
    func voiceRange() -> Void {
        print("Три актавы")
    }
}

let atristAdv1: ArtistCirqusAdvanced = ArtistCirqusAdvanced(name: "Запашный"
                                        ,country: "РФ"
                                        ,genry: "опасный"
                                        ,amimals: "Тигр")
let atristAdv2: ArtistPhilharmonicAdvanced = ArtistPhilharmonicAdvanced(name: "Евгений Дятлов"
                                                    ,country: "РФ"
                                                    ,genry: "романтичный"
                                                    ,musicalInstrument: "Гитара")
let atristAdv3: ArtistOperaAdvanced = ArtistOperaAdvanced(name: "Месняев"
                                      ,country: "РФ"
                                      ,genry: "оперный"
                                      ,voiceLevel: "Бас")

// Задача 2
// ----------------
/*
 Создайте пустой массив, чтобы потом добавить в него ваших артистов;
 Добавьте созданных ранее артистов в массив;
 Напишите отчет о том, что вы поняли/в чем разобрались, выполняя это задание;
 Дайте оценку своему пониманию данной тем
 */

var arrayArtist: [AnyObject] = []

arrayArtist.append(atristAdv1 as AnyObject)
arrayArtist.append(atristAdv2 as AnyObject)
arrayArtist.append(atristAdv3 as AnyObject)
arrayArtist.append(atrist1 as AnyObject)
arrayArtist.append(atrist2 as AnyObject)
arrayArtist.append(atrist3 as AnyObject)


//пример использования опциональной формы оператора понижающего приведения as?

print("---------------------")
for atrist in arrayArtist {
    if let atristCirqusAdv = atrist as? ArtistCirqusAdvanced {
        atristCirqusAdv.dangerousLevel()
    } else if let artistPhilharmonicAdv = atrist as? ArtistPhilharmonicAdvanced {
        artistPhilharmonicAdv.harmonicSound()
    } else if let artistOperaAdv = atrist as? ArtistOperaAdvanced {
        artistOperaAdv.voiceRange()
    } else {
        print("найден другие класс")
    }
}

//пример использовать операторы as в кейсах конструкции switch для определения типа
print("---------------------")
for atrist in arrayArtist {
    switch atrist {
    case let atristCirqusAdv as ArtistCirqusAdvanced :
        atristCirqusAdv.dangerousLevel()
    case let artistPhilharmonicAdv as ArtistPhilharmonicAdvanced :
        artistPhilharmonicAdv.harmonicSound()
    case let artistOperaAdv as ArtistOperaAdvanced :
        artistOperaAdv.voiceRange()
    default:
        print("найден другие класс")
    }
}

/* Напишите отчет о том, что вы поняли/в чем разобрались, выполняя это задание;
  Дайте оценку своему пониманию данной темы
 
 Тема наслелования и переопределения в общих принипах понятна и использовалась уже в решении предыдущих заданий
 Тема о "Приведении типов" изучена по статье
 https://swiftbook.ru/content/languageguide/type-casting/
 Выше приведены примеры двух видов приведения типов.
 На текущий момент вопросов на понимание нет. Если будет какая-то более изощренная задача, то возможно вопросы появятся
 */
