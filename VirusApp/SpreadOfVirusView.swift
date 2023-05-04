//
//  SpreadOfVirusView.swift
//  VirusApp
//
//  Created by Александра Маслова on 04.05.2023.
//

import SwiftUI

struct SpreadOfVirusView: View {
   @ObservedObject var model = Model()
    
    var body: some View {
        
            VStack(spacing: 10) {
                ForEach(0..<self.model.matrix.count, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<self.model.matrix[0].count, id: \.self) { col in
                            Button(action: {
                                self.model.infectionProcess(at: (row, col), withInfectionFactor: self.model.selectedFactor)
                            }) {
                                Text (self.model.matrix[row][col] ? "🦠" : "👤")
                                    .font(.title)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    
}

struct SpreadOfVirusView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadOfVirusView()
    }
}

