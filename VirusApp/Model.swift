//
//  Model.swift
//  VirusApp
//
//  Created by Александра Маслова on 05.05.2023.
//

import Foundation

class Model: ObservableObject {
    
    private let timeInterval: Double
    private let col: Int
    private let row: Int
     let selectedFactor: Int
    
    @Published var infectedCount = 0 {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        }
    @Published var healthyCount: Int {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        }

    
    @Published var matrix: [[Bool]] {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    init(numberOfPeople: Int, vm: ViewModel) {
        let c = vm.createMatrix(for: numberOfPeople)[0]
        let r = vm.createMatrix(for: numberOfPeople)[1]
        self.col = c
        self.row = r
        self.matrix = Array(repeating: Array(repeating: false, count: c), count: r)
        self.healthyCount = r * c
        self.selectedFactor = vm.selectedFactor
        self.timeInterval = vm.timeInterval
    }


    private var operationQueue = OperationQueue()
    private var dispatchGroup = DispatchGroup()

    func infectionProcess(at point: (row: Int, col: Int), withInfectionFactor factor: Int) {
        matrix[point.row][point.col] = true
        infectedCount += 1
        healthyCount -= 1
        operationQueue.addOperation {
            self.dispatchGroup.enter()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.timeInterval) {
                self.spreadInfection(at: (point.row, point.col), withInfectionFactor: factor)
                self.dispatchGroup.leave()
            }
        }
        operationQueue.addOperation { [self] in
            self.dispatchGroup.wait()
            while self.infectedCount < col*row {
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
       // Если количество соседей меньше infectionFactor, выбираем рандомное число между нулем и количеством соседей
       var numInfected = Int.random(in: 0..<min(infectionFactor, neighbors.count))
           neighbors.shuffle()

           let localQueue = DispatchQueue(label: "localQueue")

           for neighbor in neighbors {
               if numInfected > 0 {
                   localQueue.async { [self] in
                       DispatchQueue.main.async {
                           if self.matrix[neighbor.row][neighbor.col] == false {
                               self.matrix[neighbor.row][neighbor.col] = true
                           
                               self.infectedCount += 1
                               self.healthyCount -= 1
                           }
                       }
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
