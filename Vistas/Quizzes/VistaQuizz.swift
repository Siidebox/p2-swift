//
//  VistaQuizz.swift
//  Practica-1
//
//  Created by b116 DIT UPM on 8/11/22.
//

import SwiftUI

struct VistaQuizz: View {
    
    var quiz : QuizItem
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if (verticalSizeClass == .compact){
            HStack{
                AsyncImage(url: quiz.attachment?.url){   phase in
                    if quiz.attachment?.url == nil{
                        Color.red
                    }
                    else if let image = phase.image {
                        image.resizable()
                    }
                    else if phase.error != nil{
                        Color.yellow
                    }
                    else {
                        ProgressView()
                    }
                }
                .frame(width: 180, height: 100)
                
                .foregroundColor(Color.green)
                .border(Color.black, width: 4)
                
                VStack{
                    Text(quiz.question).fontWeight(.black).multilineTextAlignment(.center).padding(20)
                    
                    Image(quiz.favourite ? "estrella" : "benzema")
                        .resizable()
                        .frame(width: 30  ,height: 30)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 2))
                    
                }
                Spacer()
                VStack{
                    AsyncImage(url: quiz.author?.photo?.url){   phase in
                        if quiz.author?.photo?.url == nil{
                            Color.red
                        }
                        else if let image = phase.image {
                            image.resizable()
                        }
                        else if phase.error != nil{
                            Color.yellow
                        }
                        else {
                            ProgressView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 2))
                    
                    Text(quiz.author?.username ?? "anonimo")
                }
            }
            
        }else{
            VStack{
                
                HStack{
                    
                    AsyncImage(url: quiz.attachment?.url){   phase in
                        if quiz.attachment?.url == nil{
                            Color.red
                        }
                        else if let image = phase.image {
                            image.resizable()
                        }
                        else if phase.error != nil{
                            Color.yellow
                        }
                        else {
                            ProgressView()
                        }
                    }
                    .frame(width: 180, height: 100)
                    
                    .foregroundColor(Color.green)
                    .border(Color.black, width: 4)
                    
                    Image(quiz.favourite ? "estrella" : "benzema")
                        .resizable()
                        .frame(width: 30  ,height: 30)
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 2))
                  
                    
                   
                }
                Text(quiz.question).fontWeight(.black).multilineTextAlignment(.center)

                HStack{
                    Text(quiz.author?.username ?? "anonimo")
                    Spacer()
                    AsyncImage(url: quiz.author?.photo?.url){   phase in
                        if quiz.author?.photo?.url == nil{
                            Color.red
                        }
                        else if let image = phase.image {
                            image.resizable()
                        }
                        else if phase.error != nil{
                            Color.yellow
                        }
                        else {
                            ProgressView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 2))
                    
                }
                
                
                
                
            }
        }
        
       
        
        
        
    }
}

/*struct VistaQuizz_Previews: PreviewProvider {
 static var previews: some View {
 VistaQuizz()
 }
 }
 */
