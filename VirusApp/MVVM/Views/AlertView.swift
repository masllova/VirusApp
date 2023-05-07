//
//  AlertView.swift
//  VirusApp
//
//  Created by Александра Маслова on 07.05.2023.
//

import SwiftUI

struct InfAlert: View {
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Button {
                showAlert = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(Color("GreenColor"))
                    .font(.title)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Параметры настройки модели"), message: Text("""
🦠 Размер группы - количесво людей в моделируемой группе.
🦠 Фактор инфицирования - количесво людей, которое может быть заражено 1 человеком при контакте.
🦠 Темп заражения - период обновления модели в секундах.
"""), dismissButton: .default(Text("Понятно")))
        }
    }
}

