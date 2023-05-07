//
//  ViewModel.swift
//  VirusApp
//
//  Created by Александра Маслова on 06.05.2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var numberOfPeople = 25
    @Published var selectedFactor = 1
    @Published var timeInterval = 1.0
    
    let range = [25, 32, 50, 72, 98, 128, 162, 200, 242, 288, 338, 392, 450, 512, 578, 648, 722, 800, 882, 968, 1058, 1152, 1250]
    // условие вхождения в массив: число, поделенное на 2, имеет целочисленный квадратный корень. Так на визуальном представлении отношения сторон будет 1:1 или 2:1
    func createMatrix(for number: Int) -> [Int] {
        // мы берем только числа из массива для вызова функции
            let col = sqrt(Double(number / 2))
            let row = number / Int(col)
            return [Int(col), row]
    }
}
