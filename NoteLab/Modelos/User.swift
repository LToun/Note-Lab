//
//  User.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 22/09/21.
//

import Foundation
import UIKit
struct User:Restable{
    let id:Int?
    let public_id:String?
    let name:String?
    let password:String?
    let admin: Bool?
    let email:String?
    let universidad:String?
    let carrera:String?
    let semestre:Int?
    
    
    init(name:String,password:String,email:String,universidad:String,carrera:String,semestre:Int) {
        self.name=name
        self.password=password
        self.email=email
        self.universidad=universidad
        self.carrera=carrera
        self.semestre=semestre
        
        self.id=nil
        self.public_id=nil
        self.admin=nil
    }
}
