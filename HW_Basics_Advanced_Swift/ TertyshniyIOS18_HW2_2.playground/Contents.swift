import UIKit

// Задача 1
// ----------------
/*
 Вы разрабатываете библиотеку аудиотреков. Вам необходимо реализовать одну из категорий музыки, наполненную треками.

 Алгоритм выполнения
 Создайте объект трек.
 Определите в нем свойства имя, исполнитель, длительность и страна.
 Создайте класс категория.
 Объявите в нем свойства название категории, список треков и количество треков в списке (экспериментируйте с "ленивыми" и вычисляемыми свойствами).
 Определите методы добавления и удаления треков в эту категорию.
*/

struct SongName: Hashable {
    var name: String
    var singer: String
    var key: String {
        return name.replacingOccurrences(of: " ", with: "").uppercased()+"/"+singer.replacingOccurrences(of: " ", with: "").uppercased()
    }
    var info: String {
        return "\(singer) / \(name)"
    }
    var infoFull: String {
        return "\(info) [key=\(key)]"
    }
    // Hashable protocol
    static func == (lhs: SongName, rhs: SongName) -> Bool {
        return lhs.key == rhs.key
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

//
struct SongTrack: Hashable {
    var song: SongName
    var duration: Int?
    var country: String?
    var info: String {
        var durationStr: String
        var countryStr: String
        if let durationValue = duration {
            durationStr = String(durationValue)
        } else {
            durationStr = "nil"
        }
        if let countryValue = country {
            countryStr = countryValue
        } else {
            countryStr = "nil"
        }
        return "\(song.info) ( \(durationStr) сек, \(countryStr) )"
    }
    
    lazy var trackFile: String = readFile()
    
    init(into song: SongName) {
        self.song = song
    }
    init(into song: SongName,duration: Int,country: String) {
        self.init(into: song)
        self.duration = duration
        self.country = country
    }
    
    private func readFile() -> String {
        return "file with track readed"
    }
    
    // Hashable protocol
    static func == (lhs: SongTrack, rhs: SongTrack) -> Bool {
        return lhs.song == rhs.song
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(song)
    }
}

//
class SongsCategory: Hashable {
    var name: String
    var list: Set<SongTrack>
    var count: Int {
        return self.list.count
    }
    var key: String {
        return name.replacingOccurrences(of: " ", with: "").uppercased()
    }
    
    init(into name: String) {
        self.name = name
        self.list = []
    }
    
    //Add members
    func add(_ track: SongTrack) -> Bool {
        return list.insert(track).inserted
    }
    func add(songName: SongName) -> Bool {
        return add(SongTrack(into: songName))
    }
    func add(name: String, singer: String) -> Bool {
        return add(SongTrack(into: SongName(name: name, singer: singer)))
    }
    func add(name: String, singer: String, duration: Int,country: String) -> Bool {
        return add(SongTrack(into: SongName(name: name, singer: singer), duration: duration, country: country))
    }
    
    // Remove members
    func remove(_ track: SongTrack) -> Bool {
        if let _ = list.remove(track) {
            return true
        } else {
            return false
        }
    }
    func remove(songName: SongName) -> Bool {
        return remove(SongTrack(into: songName))
    }
    func remove(name: String, singer: String) -> Bool {
        return remove(SongTrack(into: SongName(name: name, singer: singer)))
    }

    // Hashable protocol
    static func == (lhs: SongsCategory, rhs: SongsCategory) -> Bool {
        return lhs.key == rhs.key
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

}

let song1: SongName = SongName(name: "Until It Sleeps", singer: "Metallica")
let song2: SongName = SongName(name: "Always Be My Baby", singer: "Mariah Carey")
let song3: SongName = SongName(name: "Children", singer: "Robert Miles")

print("song1: \(song1.infoFull)")
print("song2: \(song2.infoFull)")
print("song3: \(song3.infoFull)")


let track1: SongTrack = SongTrack(into: song1)
let track2: SongTrack = SongTrack(into: song2)
let track3: SongTrack = SongTrack(into: song3)
let track4: SongTrack = SongTrack(into: SongName(name: "Лицей", singer: "Осень"), duration: 256, country: "RU")

print("track1: \(track1.info)")
print("track2: \(track2.info)")
print("track3: \(track3.info)")
print("track4: \(track4.info)")

let mySCategory1: SongsCategory = SongsCategory(into: "Дискотека 90-х")
let mySCategory2: SongsCategory = SongsCategory(into: "Дискотека 80-х")
let mySCategory3: SongsCategory = SongsCategory(into: "Дискотека 70-х")
let mySCategory4: SongsCategory = SongsCategory(into: "Просто песни")

mySCategory1.add(name:"Ясный мой свет", singer:"Татьяна Буланова",duration:50, country:"RU")
mySCategory1.add(name:"Бедная овечка" , singer:"Алена Свиридова" ,duration:60, country:"RU")
mySCategory1.add(name:"42 Минуты"     , singer:"Валерий Сюткин"  ,duration:90, country:"RU")

mySCategory2.add(track1)
mySCategory2.add(track2)
mySCategory2.add(track3)

mySCategory3.add(name:"Brother Louie"  ,singer:"Modern Talking")
mySCategory3.add(name:"Jungle Boy"     ,singer:"John Eddie")
mySCategory3.add(name:"A Kind Of Magic",singer:"Queen")

// Задача 2
// ----------------
/*

 Доработайте свою библиотеку так, чтобы в ней было несколько категорий.

 Алгоритм выполнения
 - Создайте класс библиотеки. Этот класс будет аналогичен классу категории, только хранить он должен список категорий.
 */

class SongsLibraty: Hashable {
    var name: String
    var list: Set<SongsCategory>
    var count: Int {
        return self.list.count
    }
    var key: String {
        return name.replacingOccurrences(of: " ", with: "").uppercased()
    }
    init(name: String) {
        self.name = name
        self.list = []
    }

    //Add members
    func add(_ categoty: SongsCategory) -> Bool {
        return list.insert(categoty).inserted
    }
    func add(name: String) -> Bool {
        return add(SongsCategory(into: name))
    }
    
    // Remove members
    func remove(_ categoty: SongsCategory) -> Bool {
        if let _ = list.remove(categoty) {
            return true
        } else {
            return false
        }
    }
    func remove(name: String) -> Bool {
        return remove(SongsCategory(into: name))
    }
    
    func move(track: SongTrack , categoryFrom: SongsCategory, categoryTo: SongsCategory)  ->Bool {
        if let catFrom = list.firstIndex(of: categoryFrom), let catTo = list.firstIndex(of: categoryTo)  {
            if let trcValue = list[catFrom].list.firstIndex(of: track) {
                list[catTo].add(list[catFrom].list[trcValue])
                list[catFrom].remove(list[catFrom].list[trcValue])
                return true
            }
        }
        return false
    }

    // Hashable protocol
    static func == (lhs: SongsLibraty, rhs: SongsLibraty) -> Bool {
        return lhs.key == rhs.key
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}


let mySongsLibraty: SongsLibraty = SongsLibraty(name: "Библиотека для дискотек")
mySongsLibraty.add(mySCategory1)
mySongsLibraty.add(mySCategory2)
mySongsLibraty.add(mySCategory3)
mySongsLibraty.add(mySCategory4)

// Задача 3
// ----------------
/*
Преобразуйте классы так, чтобы в пределах вашей библиотеки можно было обмениваться треками между категориями.
 */

// добавим в класс SongsLibraty метод перемещения треков

for listCat in mySongsLibraty.list {
    print(listCat.name)
    for listTrack in listCat.list {
        print(" --> \(listTrack.info)")
    }
}

print("----------------")
mySongsLibraty.move(track: SongTrack(into: SongName(name:"42 Минуты"     , singer:"Валерий Сюткин"))
                    , categoryFrom: mySCategory1
                    , categoryTo: mySCategory3)

for listCat in mySongsLibraty.list {
    print(listCat.name)
    for listTrack in listCat.list {
        print(" --> \(listTrack.info)")
    }
}

print("----------------")
mySongsLibraty.move(track: SongTrack(into: SongName(name:"Children", singer: "Robert Miles" ))
                    , categoryFrom: SongsCategory(into: "Дискотека 80-х")
                    , categoryTo: SongsCategory(into: "Просто песни"))

for listCat in mySongsLibraty.list {
    print(listCat.name)
    for listTrack in listCat.list {
        print(" --> \(listTrack.info)")
    }
}
