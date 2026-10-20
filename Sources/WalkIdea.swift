import Foundation

struct WalkIdea: Identifiable, Equatable {
    let id: String
    let title: String
    let symbol: String
    let minutes: Int
    let setting: String
    let mission: String

    static let samples: [WalkIdea] = [
        .init(id: "tree", title: "找一棵喜歡的樹", symbol: "tree.fill", minutes: 15,
              setting: "公園或校園", mission: "觀察葉子的形狀，找出三種不同的綠色。"),
        .init(id: "cloud", title: "抬頭看一朵雲", symbol: "cloud.sun.fill", minutes: 10,
              setting: "視野開闊的步道", mission: "停在安全的位置，替眼前的雲取個名字。"),
        .init(id: "book", title: "走進附近的書店", symbol: "books.vertical.fill", minutes: 30,
              setting: "住家附近的書店", mission: "找一本平常不會翻開的書，讀一頁就好。"),
        .init(id: "water", title: "聽聽水的聲音", symbol: "water.waves", minutes: 20,
              setting: "設有護欄的河岸步道", mission: "沿著步道慢走，分辨水聲和風聲。"),
        .init(id: "flower", title: "尋找街角的小花", symbol: "camera.macro", minutes: 15,
              setting: "人行道或社區花圃", mission: "觀察一朵花的顏色與花瓣，不摘取植物。"),
        .init(id: "sound", title: "收集三種聲音", symbol: "ear.fill", minutes: 10,
              setting: "安靜且安全的街區", mission: "找個不妨礙通行的位置，留意三種不同的聲音。")
    ]
}

enum WalkPicker {
    // 抽過之後先排除上一筆；空陣列或只有一筆時仍可安全處理。
    static func draw<R: RandomNumberGenerator>(from ideas: [WalkIdea],
                                                excluding previousID: String?,
                                                using generator: inout R) -> WalkIdea? {
        let alternatives = ideas.filter { $0.id != previousID }
        return (alternatives.isEmpty ? ideas : alternatives).randomElement(using: &generator)
    }

    static func draw(from ideas: [WalkIdea], excluding previousID: String?) -> WalkIdea? {
        var generator = SystemRandomNumberGenerator()
        return draw(from: ideas, excluding: previousID, using: &generator)
    }
}
