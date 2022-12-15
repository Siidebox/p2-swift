//
//  Score.swift
//  laboratorio
//
//  Created by b116 DIT UPM on 25/11/22.
//

import Foundation


class Scoremodel: ObservableObject{
    @Published private(set) var correctas : Set<Int> = []
    @Published private(set) var contadorTotal :Set<Int> = []
    
    let preferencias = UserDefaults.standard
    
    
    init() {
        contadorTotal = Set(preferencias.array(forKey: "total") as? [Int] ?? [] )
        
    }
    
    
    
    
    func insertar(objetoquiz : QuizItem){
        correctas.insert(objetoquiz.id)
        contadorTotal.insert(objetoquiz.id)
        
    }
    func reset(){
        correctas.removeAll()
    }
    
    func coso(quiz:QuizItem){
        preferencias.set(Array(contadorTotal), forKey: "total")
    }
    
    
}

