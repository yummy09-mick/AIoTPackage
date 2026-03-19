//
//  ToBePicked.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/22.
//

import SwiftUI

struct PackagePickList: View{
    @State private var showErrorAlert = false
    @State private var alertMessage = ""
    @Environment(PackageViewModel.self) var packageVM
    var bePickedPackages: [PackageModel] {
        packageVM.packages.filter { $0.state == "bePicked" }
    }
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                    .frame(height: 20)
                ForEach(bePickedPackages){ package in
                    PackageRow(package: package) { scannedCode in
                        // 這裡就是掃描完成後，交由外層處理的「商業邏輯」
                        if scannedCode == package.barCode {
                            print("掃描正確！準備跳轉畫面")
                        } else {
                            alertMessage = "條碼不符！\n您掃描的條碼為：\(scannedCode)\n正確應為：\(package.barCode)"
                            showErrorAlert = true
                        }
                    }
                }
            }
            .alert("掃描錯誤", isPresented: $showErrorAlert) {
                Button("確定", role: .cancel) {
                    // 點擊確定後不需要特別做什麼，Alert 會自動關閉
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    PackagePickList()
        .environment(PackageViewModel())
}
