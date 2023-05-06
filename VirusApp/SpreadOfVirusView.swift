//
//  SpreadOfVirusView.swift
//  VirusApp
//
//  Created by Александра Маслова on 04.05.2023.
//

import SwiftUI

struct SpreadOfVirusView: View {
    @ObservedObject var model = Model(numberOfPeople: ViewModel().numberOfPeople)
    @State private var isTapped = false
    @State var sourceOfVirus = [(Int, Int)]()
    
    @State private var zoomScale: CGFloat = 1.0
    let minZoom: CGFloat = 0.5
    let maxZoom: CGFloat = 1.5
    
    
    var body: some View {
        
        VStack {
            ZStack {
                Color("VirusColor")
                    .ignoresSafeArea()
                   HStack (spacing: UIScreen.main.bounds.width / 8){
                       Text("Healthy = \(self.model.healthyCount)")
                           
                       Text("Infected = \(self.model.infectedCount)")
                   }
                   .bold()
                   .font(.headline)
                   .lineLimit(1)
                   .padding()
                   .foregroundColor(.white)
                   
               }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)

            ScrollView ([.horizontal, .vertical]){
                VStack {
                    ForEach(0..<self.model.matrix.count, id: \.self) { row in
                        HStack {
                            ForEach(0..<self.model.matrix[0].count, id: \.self) { col in
                                Button(action: {
                                    self.model.infectionProcess(at: (row, col), withInfectionFactor: self.model.selectedFactor)
                                    sourceOfVirus.append((row, col))
                                }) {
                                    if  sourceOfVirus.contains(where: { $0 == (row, col)}) {
                                        Text("☣️")
                                            .font(.title2)
                                    } else {
                                        Text (self.model.matrix[row][col] ? "🦠" : "👤")
                                            .font(.title2)
                                    }
                                }
                            }
                        }
                    }
                } .padding()
                    
                    .scaleEffect(zoomScale)
                    
                
            }.overlay(zoomControls, alignment: .bottomTrailing)
                
        }
        

    }
    
    private var zoomControls: some View {
        VStack (spacing: UIScreen.main.bounds.width / 15) {
            Button {zoomScale = min(zoomScale + 0.1, maxZoom)} label: {
                Image(systemName: "plus.magnifyingglass")
                   
            }
            Button {zoomScale = max(zoomScale - 0.1, minZoom)} label: {
                Image(systemName: "minus.magnifyingglass")
                    
            }
            
            
        }
        .font(.title)
        .foregroundColor(Color("VirusColor"))
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 4)
        .padding(.trailing)
    }
    
    
}

struct SpreadOfVirusView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadOfVirusView()
    }
}

