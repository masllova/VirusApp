//
//  MenuView.swift
//  VirusApp
//
//  Created by Александра Маслова on 04.05.2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm = ViewModel()
    
    @State private var showSimulator = false
    @State private var selectedInd: Double = 0
    @State private var infFactor = 0.0
    @State private var updateTimer = 0.0
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack (spacing: 50) {
                Text("Симулятор вируса")
                    .foregroundColor(Color("AccentOrangeColor"))
                    .font(.system(size: 40))
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Spacer()
                VStack {
                    HStack {
                        Text("Размер групы")
                            .font(.title2).bold()
                        Spacer()
                        Text("\(vm.range[Int(selectedInd)])")
                            .font(.title2).bold()
                        
                    }
                    LockerSlider(value: $selectedInd, in: 0...Double(vm.range.count - 1), step: 1)
                        .onChange(of: selectedInd) { value in
                            vm.numberOfPeople = vm.range[Int(value)]
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 15)
                    
                    HStack {
                        Text("Фактор инфицирования")
                            .font(.title2).bold()
                        Spacer()
                        Text("\(Int(infFactor + 1))")
                            .font(.title2).bold()
                    }
                    
                    LockerSlider(value: $infFactor, in: 0...9)
                        .onChange(of: infFactor) { value in
                            vm.selectedFactor = Int(value + 1)
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 15)
                    HStack {
                        Text("Темп заражения (сек)")
                            .font(.title2).bold()
                        Spacer()
                        Text("\(Int(updateTimer + 1))")
                            .font(.title2).bold()
                    }
                    
                    LockerSlider(value: $updateTimer, in: 0...9)
                        .onChange(of: updateTimer) { value in
                            vm.timeInterval = Double(value + 1)
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 15)
                    
                }.padding()
                    .padding(.vertical)
                    .foregroundColor(.white)
                    .background(Rectangle().foregroundColor(Color("OrangeColor")))
                    .cornerRadius(15)
                    .shadow(radius: 15)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                Button(action: {self.showSimulator.toggle()}) {
                    Text("Запустить моделирование")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                }.sheet(isPresented: $showSimulator) {
                    SpreadOfVirusView(model: Model(numberOfPeople: vm.numberOfPeople, vm: vm))
                }
                .padding()
                .background(Capsule().foregroundColor(Color("VirusColor")).shadow(radius: 10))
                Spacer()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
