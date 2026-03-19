//
//  Package.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/21.
//

import SwiftUI

struct PackageView: View {
    @State private var selectedTab: PackageSegment = .ToBePicked
    @Namespace private var animation
    var body: some View {
        VStack{
            Rectangle()
                .foregroundStyle(Colors.mainColor)
                .frame(height: 63)
            ZStack{
                selectedTab.displayView
                GeometryReader{ geom in
                    VStack{
                        ZStack{
                            HStack{
                                ForEach(PackageSegment.allCases, id: \.self){ item in
                                    ZStack{
                                        Text(item.title)
                                            .foregroundStyle(selectedTab == item ? Colors.mainColor : Colors.subColor)
                                            .font(.system(size: 21 - CGFloat(PackageSegment.allCases.count - 1)))
                                            .frame(width: (geom.size.width - 40) / CGFloat(PackageSegment.allCases.count))
                                        
                                        if selectedTab == item{
                                            Capsule()
                                                .foregroundStyle(Colors.mainColor)
                                                .frame(height: 3)
                                                .matchedGeometryEffect(id: "showLine", in: animation)
                                                .frame(width: (geom.size.width - 20) / CGFloat(PackageSegment.allCases.count + 1))
                                                .offset(y: geom.size.height * 0.022)
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            selectedTab = item
                                        }
                                    }
                                }
                            }
                            Capsule()
                                .foregroundStyle(Colors.subColor.opacity(0.1))
                                .frame(height: 2)
                                .offset(y: geom.size.height * 0.022)
                        }
                        .padding(.top, 10)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}


#Preview {
    PackageView()
        .environment(PackageViewModel())
}

// MARK: - Segment Control viewModel
enum PackageSegment: CaseIterable{
    case ToBePicked, Received, Returned
    
    var title: String{
        switch self {
        case .ToBePicked:
            return "待領取"
        case .Received:
            return "已領取"
        case .Returned:
            return "已退回"
        }
    }
    
    var displayView: AnyView{
        switch self {
        case .ToBePicked:
            return AnyView(PackagePickList().padding(.top, 40))
        case .Received:
            return AnyView(ReceivedView().padding(.top, 40))
        case .Returned:
            return AnyView(ReturnedView().padding(.top, 40))
        }
    }
}
