# 散步靈感抽籤（走走籤）

原生 SwiftUI iOS App，最低 iOS 17。六筆散步提案都在本機，不需帳號、網路或第三方套件。圖片使用 Apple SF Symbols；不含外部照片。

## 開啟及操作

1. 用 Xcode 開啟 `WalkLottery.xcodeproj`，選擇 `WalkLottery` scheme。
2. 選一台已安裝 runtime 的 iPhone 模擬器，按 Run。
3. 點「抽一個散步靈感」，閱讀插圖、活動名稱、分鐘數、建議地點、小任務。
4. 點「再抽一次」，會排除上一筆，避免連續抽到同一個提案。結束 App 再開會回到初始畫面，沒有儲存抽籤紀錄。

專案已附完整 `.xcodeproj`，一般開啟不需 XcodeGen。若修改 `project.yml`，有安裝 XcodeGen 的環境可在本目錄執行 `xcodegen generate` 重建專案。

## 重跑驗證

在本目錄執行（自行替換 `SIMULATOR_ID`；使用 `xcrun simctl list devices available` 查詢）：

```sh
xcodebuild test -project WalkLottery.xcodeproj -scheme WalkLottery \
  -destination 'platform=iOS Simulator,id=SIMULATOR_ID' \
  -derivedDataPath ../DerivedData-review \
  -resultBundlePath ../logs/review.xcresult CODE_SIGNING_ALLOWED=NO
```

`resultBundlePath` 必須是尚不存在的路徑。測試包含資料完整性、1000 次抽選的合法範圍與不連續重複、空集合及單筆集合，以及真正啟動 App 的按鈕操作與圖文呈現。這些檢查不構成隨機分布均勻的統計證明。

目前專案為模擬器免簽章設定。若要跑實機，請在 Xcode 設定自己的 Team、唯一 Bundle ID 並啟用 Code Signing；本次未做實機簽章或安裝。

## 檔案

- `Sources/WalkIdea.swift`：自訂型別、六筆 Array 資料、可注入亂數產生器的抽選邏輯。
- `Sources/ContentView.swift`：SwiftUI 畫面、`@State` 與按鈕。
- `Sources/WalkLotteryApp.swift`：App 入口。
- `Tests/WalkPickerTests.swift`：單元測試。
- `UITests/WalkLotteryUITests.swift`：UI 測試及原生截圖附件。
