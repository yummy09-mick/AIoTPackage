//
//  ReceivedView.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/22.
//

import SwiftUI

struct ReceivedView: View{
    @Environment(PackageViewModel.self) var packageVM
    var receivedPackages: [PackageModel] {
        packageVM.packages.filter { $0.state == "Received" }
    }
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                    .frame(height: 20)
                if receivedPackages.isEmpty{
                    Text("目前還未領取任何包裹")
                }else{
                    ForEach(receivedPackages){ package in
                        PackageRowDetail(package: package)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ReceivedView()
        .environment(PackageViewModel())
}
