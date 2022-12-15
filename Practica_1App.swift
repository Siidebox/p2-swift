//
//  Practica_1App.swift
//  Practica-1
//
//  Created by b116 DIT UPM on 8/11/22.
// Hecho por
import SwiftUI

@main
struct Practica_1App: App {
    //obejto QuizzesModel vacio, cuando llame a load se llena
    var QuizModelo = QuizzesModel()
    var ScoreModelo = Scoremodel()
    
    var body: some Scene {
        WindowGroup {   //con.enviro... Le paso una "propiedad" como react
            ListaQuizzes().environmentObject(QuizModelo).environmentObject(ScoreModelo)
        }
    }
}
