//
//  ViewModel.swift
//  VirusApp
//
//  Created by Александра Маслова on 06.05.2023.
//

import Foundation

struct ViewModel {
    let numberOfPeople = 50
    let selectedFactor = 2
    let timeInterval = 1.0
 
    func createMatrix(for number: Int) -> [Int] {
        let aspectRatio = 7.0/3.0
        let matrixSize = Int(sqrt(Double(number) * aspectRatio))
        let rows = Int(Double(matrixSize) / aspectRatio)
        let columns = matrixSize
        
        return [rows, columns]
    }
}


struct Functions {
    
   
}
