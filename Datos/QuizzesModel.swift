//
//  QuizzesModel.swift
//  Quiz con SwiftUI
//
//  Created by Santiago Pavón Gómez on 18/10/22.
//

import Foundation

//heredar todo lo de clase ya hecha ObservableObject en Quizzmodel. ObservableObject repinta cada vez que varia algo

class QuizzesModel: ObservableObject {
    
    // Los datos
    // quizzes es una variable. Array [] del tipo QuizItem y luego () para llamar al constructor de Quizitem
    
    
    //@published publica cambios. Todo el acceda sabe que ha cambiado y entonces volverá a repintarse
    
    @Published private(set) var quizzes = [QuizItem]()
    

    // private(set) es porque es un array con mis quizz providos, otros archivos pueden verla, pero ninungo salvo este archivo puede modificarla (set)
    private let urlcore = "https://core.dit.upm.es"
    private let pathQuizzes = "/api/quizzes/random10wa?token"
    private let token = "9f189b316103b6cec6d9"
    private let pathFav = "/api/users/tokenOwner/favourites/"
    
    //load es el carga datos del server o desde un archivo.Guarda los quizzes del server en nuestro array quizzes
    func load() {
        
        guard let jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            //data es un objeto Data con el contenido de la direccion jsonURL. Puede lanzar errores de ahi el try
            let data = try Data(contentsOf: jsonURL)
            //decode, maquina de decodifica json
            let decoder = JSONDecoder()
            
            // if let str = String(data: data, encoding: String.Encoding.utf8) {
            //                print("Quizzes ==>", str)
            //            }
            
            
            // decode. quiero que desde data me devuelvas un array de QuizItems
            self.quizzes = try decoder.decode([QuizItem].self, from: data)
            
            print("Quizzes cargados")
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
    
    func endpointQuiz() -> URL?{
        let url = "\(urlcore)\(pathQuizzes)=\(token)"
        guard let uwu = URL(string: url) else{
            print("todo mal, estudia mas")
            return nil
        }
        return uwu
    }
    
    func endpointFav(quizId : Int) -> URL?{
        let url = "\(urlcore)\(pathFav)\(quizId)?token=\(token)"
       
        guard let uwu = URL(string: url) else{
            print("todo mal, estudia mas")
            return nil
        }
        return uwu
    }
    
    func download(){
        
       
        URLSession.shared.dataTask(with: endpointQuiz()!){ data, response, error in
            guard error == nil,
                  let response = response as?HTTPURLResponse,
                  response.statusCode == 200,
                  let data else{
                print("fallo")
                return
            }
            if let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data){
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    print("Se ha cargado bien")
                }
            } else{
                print("error en download")
            }
            
        }.resume()
        
    }
   

    
    func cambiaFAV(quizItemid : Int){
     
        guard let url = endpointFav(quizId: quizItemid) else {return}
        guard let index = (quizzes.firstIndex{ quiz in quiz.id == quizItemid}) else{
                print("no hay")
                return
            }
        
        
        var req = URLRequest(url: url)
    
       req.httpMethod = quizzes[index].favourite ? "DELETE" : "PUT"
        
        //URLSession.shared.uploadTask(with: req, from: Data?)
        
        URLSession.shared.uploadTask(with: req, from:Data()){_, response,error in
            
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200
            else{
                print("fallo")
                return
            }
            DispatchQueue.main.async{
                self.quizzes[index].favourite.toggle()
            }
            
        }.resume()
        
    }
    
    func borrar() {
       
        
    }
    
    
}
