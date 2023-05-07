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
            
            VStack{
                HStack {
                    Spacer()
                    InfAlert()
                }.padding(.horizontal)
                Spacer()
            }.padding(.bottom)
            
            VStack (spacing: 30) {
                Text("Симулятор вируса")
                    .foregroundColor(Color("AccentOrangeColor"))
                    .font(.system(size: UIScreen.main.bounds.width / 10))
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, UIScreen.main.bounds.height / 10)
                
                VStack {
                    HStack {
                        Text("Размер группы")
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
                        .onChange(of: infFactor) { value in vm.selectedFactor = Int(value) }
                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 15)
                    
                    HStack {
                        Text("Темп заражения (сек)")
                            .font(.title2).bold()
                        Spacer()
                        Text("\(Int(updateTimer + 1))")
                            .font(.title2).bold()
                    }
                    
                    LockerSlider(value: $updateTimer, in: 0...9)
                        .onChange(of: updateTimer) { value in vm.timeInterval = Double(value) }
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
                    SpreadOfVirusView(model: Model(vm: vm))
                        
                }
                .padding()
                .padding(.vertical, UIScreen.main.bounds.width / 45)
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
