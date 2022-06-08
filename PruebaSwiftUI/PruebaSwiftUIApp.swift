//
//  PruebaSwiftUIApp.swift
//  PruebaSwiftUI
//
//  Created by Alfredo Salazar on 06/06/22.
//

import SwiftUI

@main
struct PruebaSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Product())
        }
    }
}
