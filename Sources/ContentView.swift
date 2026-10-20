import SwiftUI

struct ContentView: View {
    @State private var selected: WalkIdea?
    @State private var drawCount = 0
    private let ink = Color(red: 0.12, green: 0.25, blue: 0.19)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Label("走走籤", systemImage: "figure.walk")
                        .font(.headline)
                    Spacer()
                    Text("日常的小探險").font(.caption)
                }
                .foregroundStyle(ink)

                VStack(alignment: .leading, spacing: 10) {
                    Text("今天，\n往哪裡走？")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .fixedSize(horizontal: false, vertical: true)
                    Text("留一點時間給自己，抽一個散步靈感。")
                        .font(.body).foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 18) {
                    HStack(alignment: .top) {
                        Image(systemName: selected?.symbol ?? "leaf.fill")
                            .font(.system(size: 64)).foregroundStyle(ink)
                            .frame(minHeight: 86)
                            .accessibilityLabel(selected.map { "插圖：\($0.title)" } ?? "葉子插圖")
                            .accessibilityIdentifier("ideaImage")
                        Spacer()
                        Text(selected == nil ? "準備出發" : "第 \(drawCount) 籤")
                            .font(.caption.monospacedDigit())
                            .padding(8).background(.white.opacity(0.65), in: Capsule())
                    }
                    if let idea = selected {
                        Text(idea.title).font(.title2.bold())
                            .accessibilityIdentifier("ideaTitle")
                        Label("時間：\(idea.minutes) 分鐘", systemImage: "clock")
                            .accessibilityIdentifier("ideaTime")
                        Label("地點：\(idea.setting)", systemImage: "mappin.and.ellipse")
                            .accessibilityIdentifier("ideaSetting")
                        Text("小任務").font(.caption.bold()).foregroundStyle(.secondary)
                        Text(idea.mission).font(.body)
                            .accessibilityIdentifier("ideaMission")
                    } else {
                        Text("把選擇交給一點隨機").font(.title2.bold())
                        Text("六個小提案，不用排行程。\n按下按鈕，看看今天的小任務。")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(Color(red: 0.86, green: 0.91, blue: 0.79),
                            in: RoundedRectangle(cornerRadius: 28))

                Button(action: draw) {
                    HStack {
                        Image(systemName: "shuffle")
                        Text(selected == nil ? "抽一個散步靈感" : "再抽一次")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline).padding(20)
                    .foregroundStyle(.white)
                    .background(ink, in: RoundedRectangle(cornerRadius: 18))
                }
                .accessibilityIdentifier("drawButton")

                Text("每次換一個靈感・離線也能抽\n請依天氣、體力與現場安全狀況調整活動。")
                    .font(.footnote).foregroundStyle(.secondary)
                    .lineSpacing(5)
            }
            .padding(24)
            .frame(maxWidth: 560)
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 0.97, green: 0.96, blue: 0.92))
        .foregroundStyle(ink)
        .preferredColorScheme(.light)
    }

    private func draw() {
        selected = WalkPicker.draw(from: WalkIdea.samples, excluding: selected?.id)
        drawCount += 1
    }
}
