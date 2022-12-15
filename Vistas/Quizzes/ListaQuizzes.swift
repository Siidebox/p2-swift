//
//  ContentView.swift
//  Practica-1
//
//  Created by b116 DIT UPM on 8/11/22.
//

import SwiftUI

struct ListaQuizzes: View {
    //@enviromnetObject busca dentro de enviroment algo del tipo QuizzesModel y lo asignas
    @EnvironmentObject var QuizModelo: QuizzesModel

    @State private var Alerta = false
    @EnvironmentObject var score : Scoremodel
    
    
    @State private var toogle = false
    @State private var fav = false
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    
    
    
    var body: some View {
        
        
        NavigationStack{
            VStack{
                Toggle("Quizzes sin acertar", isOn: $toogle)
                    .onChange(of: toogle){newValue in
                       
                    
                    }
                    .tint(.blue)
                    .scaledToFit().padding()
                Toggle("Quizzes favoritos", isOn: $fav)
                    .onChange(of: fav){newValue in
                   
                    
                    }
                    .tint(.yellow)
                    .scaledToFit().padding()
            }
           
           
                
            if (verticalSizeClass == .compact){
                
                
                List{
                    
                    ForEach(QuizModelo.quizzes){ quizitem in
                        
                    
                        if(!toogle  || !score.correctas.contains(quizitem.id)) && !fav {
                            NavigationLink{
                                VistaQuizPlay(quiz: quizitem)
                                
                            }
                        label:{
                            VistaQuizz(quiz: quizitem)
                            
                        }
                        }
                        else if (fav && quizitem.favourite) {
                            NavigationLink{
                                VistaQuizPlay(quiz: quizitem)
                                
                            }
                        label:{
                            VistaQuizz(quiz: quizitem)
                            
                        }
                        }
                       
                        
                    }
                    .padding()
                    
                }
                .navigationTitle(Text("Quiz"))
                
                .navigationBarItems(leading: Text("Score Total = \(score.contadorTotal.count)"),  trailing:Button("Nuevos Quizzes"){
                    QuizModelo.download()
                    Alerta = true
                    score.reset()
                }.alert (isPresented: $Alerta){
                    Alert(
                        title: Text("Nuevos Quizzes"),
                        message: Text("Tienes 10 quizzes nuevos para jugar"),
                        dismissButton: .default(Text("Seguir jugando")))
                    
                })
                
                
                
                
                
            }else {
                List{
                    ForEach(QuizModelo.quizzes){ quizitem in
                        if(!toogle  || !score.correctas.contains(quizitem.id)) && !fav {
                            NavigationLink{
                                VistaQuizPlay(quiz: quizitem)
                                
                            }
                        label:{
                            VistaQuizz(quiz: quizitem)
                            
                        }
                        }
                        else if (fav && quizitem.favourite) {
                            NavigationLink{
                                VistaQuizPlay(quiz: quizitem)
                                
                            }
                        label:{
                            VistaQuizz(quiz: quizitem)
                            
                        }
                        }
                        
                        
                    }
                    .padding()
                }
                .navigationTitle(Text("Quiz"))
                
                .navigationBarItems(leading: Text("Score Total = \(score.contadorTotal.count)"),  trailing:Button("Nuevos Quizzes"){
                    QuizModelo.download()
                    Alerta = true
                    score.reset()
                }.alert (isPresented: $Alerta){
                    Alert(
                        title: Text("Nuevos Quizzes"),
                        message: Text("Tienes 10 quizzes nuevos para jugar"),
                        dismissButton: .default(Text("Seguir jugando")))
                    
                })
                
            }
            
            
            
        }
        
        .onAppear{
            QuizModelo.download()
            
            
        }
        
        
        
            
                
        
    }
}
