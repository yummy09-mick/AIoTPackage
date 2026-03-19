//
//  PackageDetailView.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/24.
//

import SwiftUI

struct PackageDetail: View {
    let package: PackageModel
    @Environment(\.dismiss) private var dismiss
    @Environment(PackageViewModel.self) var packageVM
    var body: some View {
        VStack(spacing: 16){
            PackageRowDetail(package: package)
            Button{
                packageVM.markAsReceived(packageID: package.id)
                dismiss()
            }label: {
                Text("確認領取")
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Colors.mainColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    PackageDetail(package: PackageModel(state: "bePicked", code: "A10003", timeText: "今天抵達", title: "新竹物流", manager: "XXX", cabinet: "A1", floor: "3", barCode: "1234"))
        .environment(PackageViewModel())
}

