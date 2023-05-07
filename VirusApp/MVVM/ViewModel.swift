//
//  ViewModel.swift
//  VirusApp
//
//  Created by Александра Маслова on 06.05.2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var numberOfPeople = 18
    @Published var selectedFactor = 1
    @Published var timeInterval = 1.0
    
    let range = [18, 32, 50, 72, 98, 128, 162, 200, 242, 288, 338, 392, 450, 512, 578, 648, 722, 800, 882, 968, 1058, 1152, 1250]
    // условие вхождения в массив: число, поделенное на 2, имеет целочисленный квадратный корень. Так на визуальном представлении отношения сторон 2:1
    func createMatrix(for number: Int) -> [Int] {
        guard range.contains(number) else {return [6, 3]}
        // функция предназначена только для элементов range, в противном случае будет решение для range[0]
            let col = sqrt(Double(number / 2))
            let row = number / Int(col)
            return [Int(col), row]
    }
}
