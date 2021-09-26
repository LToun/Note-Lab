//
//  Note.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 22/09/21.
//

import Foundation
import UIKit

struct Note: Restable{
    let id:Int?
    let date:String?
    let text:String
    let user_id:Int?
    let semestre:Int?
    let universidad:String?
    let carrera: String?
    let materia: String?
    let author:String?
    let titulo:String?
    init(text:String,materia:String,titulo:String) {
        

        self.id=nil
        self.date=nil
        self.text=text
        self.titulo=titulo
        self.author=nil
        self.user_id=nil
        self.semestre=nil
        self.universidad=nil
        self.carrera=nil
        self.materia=materia
    }
}
