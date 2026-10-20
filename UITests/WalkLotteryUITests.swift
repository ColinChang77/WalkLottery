import XCTest

final class WalkLotteryUITests: XCTestCase {
    func testDrawShowsImageAndAllInformation() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["drawButton"].waitForExistence(timeout: 10))
        let initial = XCTAttachment(screenshot: app.screenshot())
        initial.name = "01-initial"
        initial.lifetime = .keepAlways
        add(initial)
        app.buttons["drawButton"].tap()
        XCTAssertTrue(app.staticTexts["ideaTitle"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.images["ideaImage"].exists)
        XCTAssertTrue(app.staticTexts["ideaMission"].exists)
        XCTAssertTrue(app.otherElements["ideaTime"].exists || app.staticTexts["ideaTime"].exists)
        XCTAssertTrue(app.otherElements["ideaSetting"].exists || app.staticTexts["ideaSetting"].exists)
        let first = app.staticTexts["ideaTitle"].label
        let result = XCTAttachment(screenshot: app.screenshot())
        result.name = "02-result"
        result.lifetime = .keepAlways
        add(result)
        app.buttons["drawButton"].tap()
        XCTAssertNotEqual(first, app.staticTexts["ideaTitle"].label)
    }
}
