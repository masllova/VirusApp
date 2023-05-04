//
//  Model.swift
//  VirusApp
//
//  Created by Александра Маслова on 05.05.2023.
//

import Foundation

import Foundation

class Model: ObservableObject {
    
    @Published var selectedFactor = 1
    @Published var matrix = Array(repeating: Array(repeating: false, count: 8), count: 10) {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }

    private var timeInterval = 1.5
    
    func infectionProcess(at point: (row: Int, col: Int), withInfectionFactor factor: Int) {
        matrix[point.row][point.col] = true
        Thread.sleep(forTimeInterval: timeInterval)
        spreadInfection(at: (point.row, point.col), withInfectionFactor: factor)
        //Создаем новую очередь в глобальной области запускаем в ней блок кода асинхронно с паузами пока вся матрица не будет заполнена
        DispatchQueue.global(qos: .userInitiated).async {
            while self.matrix.contains(where: { !$0.allSatisfy({ $0 == true }) }) {
                Thread.sleep(forTimeInterval: self.timeInterval)
                let infected = self.getInfectedPoints()
                for i in infected {
                    self.spreadInfection(at: (i.row, i.col), withInfectionFactor: factor)
                }
            }
        }
    }
    
   private func spreadInfection(at point: (row: Int, col: Int), withInfectionFactor infectionFactor: Int) {
        // Генерируем список соседей
        var neighbors = [(row: Int, col: Int)]()
        for row in (point.row - 1)...(point.row + 1) {
            for col in (point.col - 1)...(point.col + 1) {
                if row >= 0 && row < matrix.count && col >= 0 && col < matrix[0].count && !(row == point.row && col == point.col) {
                    neighbors.append((row: row, col: col))
                }
            }
        }
        // Если количество соседей меньше infectionFactor, берем всеx соседей
        var numInfected = min(infectionFactor, neighbors.count)
        // Выбираем рандомных соседей, которые будут заражены
        neighbors.shuffle()
        for neighbor in neighbors {
            if numInfected > 0 {
                DispatchQueue.main.async { [self] in
                    matrix[neighbor.row][neighbor.col] = true
                }

                numInfected -= 1
            } else {
                break
            }
        }
    }
    
    //находим всех заражанных (тк 1 зараженный может в последсвии снова заразить кого-то)
  private func getInfectedPoints() -> [(row: Int, col: Int)] {
        var infectedPoints = [(row: Int, col: Int)]()
        for row in 0..<matrix.count {
            for col in 0..<matrix[0].count {
                if matrix[row][col] {
                    infectedPoints.append((row: row, col: col))
                }
            }
        }
        return infectedPoints
    }
}
