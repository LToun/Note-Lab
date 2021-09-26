//
//  ViewControllerExtension.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 05/08/21.
//

import Foundation
import UIKit
extension SignUp:UIPickerViewDelegate,UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return unis.count
        case 2:
            return carrera.count
        case 3:
            return semestre.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            if unis[row].name != "Universidad Nacional Autónoma de México"{
                BetaUser()
            }
            else{
                responseLabel.text=""
            }
            return unis[row].name
        case 2:
            return carrera[row]
        case 3:
            return String(describing:semestre[row])
        default:
            return "No hay datos"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            uniTextField.text=unis[row].name
            dominioEmail.text=unis[row].domains?[0]
            uniTextField.resignFirstResponder()
            
        case 2:
            carreraTextField.text=carrera[row]
            carreraTextField.resignFirstResponder()
        case 3:
            semestreTextField.text=String(describing:semestre[row])
            semestreTextField.resignFirstResponder()
            
        default:
            print("Hay un tag extra")
        }
    }
    func GetData(){
        let urlUnis = URL(string: "http://universities.hipolabs.com/search?name=nacional&country=mexico")
        let _: Void=URLSession.shared.dataTask(with: urlUnis!) {data, _, error in
            if let error=error{
                print(error.localizedDescription)
            }
            if let data=data{
                do{
                    let vectorU = try JSONDecoder().decode([Universidades].self, from: data)
                    self.unis = vectorU
                }catch{
                    print(error)
                }
            }
            
        }.resume()
    }
}
