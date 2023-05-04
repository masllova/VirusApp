//
//  ContentView.swift
//  VirusApp
//
//  Created by Александра Маслова on 04.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
          SpreadOfVirusView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
