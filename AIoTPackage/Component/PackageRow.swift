//
//  PackageCardView.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/21.
//

import SwiftUI
import CodeScanner
internal import AVFoundation

struct PackageRow: View {
    let package: PackageModel
    @State private var isShowingScanner: Bool = false
    @State private var correct = false
    @State private var selectedPackage: PackageModel?
    var onScanResult: (String) -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("#\(package.code)")
                    .foregroundStyle(Color("mainColor"))
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Colors.mainColor.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(package.timeText)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.bottom, 12)
            
            HStack(alignment: .top, spacing: 16) {
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Colors.subColor.opacity(0.5))
                    .frame(width: 56, height: 56)
                    .overlay{
                        Image(systemName: "cube.box.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)
                    }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(package.title)
                        .font(.title3).bold()
                        .foregroundColor(Colors.mainColor)
                    
                    Text("管理員：\(package.manager)")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Colors.subColor.opacity(0.5))
                    
                    Label("\(package.cabinet) - 第\(package.floor)層", systemImage: "cabinet.fill")
                        .foregroundColor(Colors.mainColor)
                        .padding(.top, 8)
                }
                Spacer()
            }
            .padding(.bottom, 8)
            
            Divider()
            
            HStack{
                Spacer()
                Button {
                    isShowingScanner.toggle()
                } label: {
                    Label("取貨", systemImage: "barcode.viewfinder")
                        .font(.title3)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Colors.mainColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
            .padding(.top)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(.white)
                .shadow(color: Color.black.opacity(0.16),
                        radius: 10, x: 0, y: 2)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(
                codeTypes: [.code128],                 // 依你的條碼格式調整
                showViewfinder: true,
                simulatedData: package.barCode,      // 模擬值：方便在 Simulator 測試
                completion: handleScan
            )
        }
        .sheet(item: $selectedPackage) { pkg in
            PackageDetail(package: pkg)
        }
    }
    
    // 一定要在 struct 裡「外面」宣告，不要放在 body 裡
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let scanResult):
            onScanResult(scanResult.string)
            guard scanResult.string == package.barCode else {
                correct = false
                return
            }
            
            correct = true
            selectedPackage = package
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


//#Preview {
//    PackageRow(package: PackageModel(code: "", timeText: "", title: "", manager: "", cabinet: "", floor: "", barCode: "1234"))
//}
