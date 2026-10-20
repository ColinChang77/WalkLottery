import XCTest
@testable import WalkLottery

final class WalkPickerTests: XCTestCase {
    struct SeededGenerator: RandomNumberGenerator {
        var state: UInt64 = 42
        mutating func next() -> UInt64 {
            state = state &* 6364136223846793005 &+ 1442695040888963407
            return state
        }
    }

    func testDataMeetsAssignment() {
        let ideas = WalkIdea.samples
        XCTAssertGreaterThanOrEqual(ideas.count, 5)
        XCTAssertEqual(Set(ideas.map(\.id)).count, ideas.count)
        for idea in ideas {
            XCTAssertFalse(idea.title.isEmpty)
            XCTAssertFalse(idea.symbol.isEmpty)
            XCTAssertFalse(idea.setting.isEmpty)
            XCTAssertFalse(idea.mission.isEmpty)
            XCTAssertGreaterThan(idea.minutes, 0)
        }
    }

    func testRepeatedDrawsStayInDataAndDoNotRepeatImmediately() throws {
        var generator = SeededGenerator()
        var previous: WalkIdea?
        var seen = Set<String>()
        for _ in 0..<1000 {
            let idea = try XCTUnwrap(WalkPicker.draw(from: WalkIdea.samples,
                                                    excluding: previous?.id,
                                                    using: &generator))
            XCTAssertTrue(WalkIdea.samples.contains(idea))
            XCTAssertNotEqual(idea.id, previous?.id)
            seen.insert(idea.id)
            previous = idea
        }
        XCTAssertEqual(seen.count, WalkIdea.samples.count)
    }

    func testEmptyAndSingleItemInputs() {
        var generator = SeededGenerator()
        XCTAssertNil(WalkPicker.draw(from: [], excluding: nil, using: &generator))
        let only = WalkIdea.samples[0]
        XCTAssertEqual(WalkPicker.draw(from: [only], excluding: only.id,
                                       using: &generator), only)
    }
}
