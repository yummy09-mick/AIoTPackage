//
//  PackageViewModel.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/3/19.
//

import Foundation
import SwiftUI
import Observation

@Observable
class PackageViewModel {
    // 💡 1. 把原本寫在外的 packageModels 陣列搬進來
    var packages: [PackageModel] = [
        PackageModel(state: "bePicked", code: "A10003", timeText: "今天抵達", title: "新竹物流", manager: "XXX", cabinet: "A1", floor: "3", barCode: "1452445973948760"),
        PackageModel(state: "bePicked", code: "A10002", timeText: "1天前抵達", title: "FedEx", manager: "XXX", cabinet: "A1", floor: "2", barCode: "5678"),
        PackageModel(state: "bePicked", code: "A10001", timeText: "2天前抵達", title: "黑貓宅急便", manager: "XXX", cabinet: "A1", floor: "1", barCode: "9012")
    ]
    
    // 💡 2. 準備一個專門修改狀態的函式給按鈕呼叫
    func markAsReceived(packageID: UUID) {
        if let index = packages.firstIndex(where: { $0.id == packageID }) {
            packages[index].state = "Received"
            print("資料庫已更新：\(packages[index].code) 狀態變為 Received")
        }
    }
}
