//
//  SpreadOfVirusView.swift
//  VirusApp
//
//  Created by Александра Маслова on 04.05.2023.
//

import SwiftUI

struct SpreadOfVirusView: View {
    @StateObject var model: Model
    init(model: Model) {self._model = StateObject(wrappedValue: model)}
    
    @State private var isTapped = false
    @State var sourceOfVirus = [(Int, Int)]() //для учета источников заражения ☣️
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var zoomScale: CGFloat = 1.0
    let minZoom: CGFloat = 0.5
    let maxZoom: CGFloat = 1.5
    
    var body: some View {
        VStack {
            
            ZStack {
                Color("VirusColor")
                    .ignoresSafeArea()
                VStack{
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }.padding(.top)
                    Spacer()
                }
                HStack (spacing: UIScreen.main.bounds.width / 10){
                    if model.healthyCount == 0 {
                        Text("Вирус распространился")
                        .font(.headline).bold()
                    }
                    else {
                        Text("Здоровые: \(self.model.healthyCount)")
                            .font(.headline).bold()
                        Text("Зараженные: \(self.model.infectedCount)")
                            .font(.headline).bold()
                    }
                }
                
                .lineLimit(1)
                .padding()
                .padding(.top)
                .foregroundColor(.white)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
            
            ScrollView ([.horizontal, .vertical]){
                VStack {
                    ForEach(0..<self.model.matrix.count, id: \.self) { row in
                        HStack {
                            ForEach(0..<self.model.matrix[0].count, id: \.self) { col in
                                Button(action: {
                                    self.model.infectionProcess(at: (row, col),
                                                                withInfectionFactor: self.model.selectedFactor)
                                    sourceOfVirus.append((row, col))//для учета источников заражения
                                }) {
                                    if sourceOfVirus.contains(where: { $0 == (row, col)}) {
                                        Text("☣️").font(.title2)
                                    } else {
                                        Text (self.model.matrix[row][col] ? "🦠" : "👤").font(.title2)
                                    }
                                }
                            }
                        }
                    }
                }   .padding()
                    .scaleEffect(zoomScale)
            }.overlay(zoomControls, alignment: .bottomTrailing)
        }.background(Color("BackgroundColor"))
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
        SpreadOfVirusView(model: Model(vm: ViewModel()))
    }
}

