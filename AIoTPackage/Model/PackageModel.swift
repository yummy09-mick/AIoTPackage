//
//  PackageModel.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/22.
//

import Foundation
struct PackageModel: Identifiable, Hashable {
    var id = UUID()
    var state: String
    let code: String
    let timeText: String
    let title: String
    let manager: String
    let cabinet: String
    let floor: String
    let barCode: String
}

