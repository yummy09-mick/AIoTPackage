//
//  AIoTPackageApp.swift
//  AIoTPackage
//
//  Created by 葉韋坪 on 2026/2/21.
//

import SwiftUI

@main
struct AIoTPackageApp: App {
    @State private var packageViewModel = PackageViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(packageViewModel)
        }
    }
}
