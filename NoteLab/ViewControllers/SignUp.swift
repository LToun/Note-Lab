//
//  ViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 25/07/21.
//

import UIKit

class SignIn: UIViewController{

    

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    
    @IBOutlet weak var uniTextField: UITextField!
    @IBOutlet weak var carreraTextField: UITextField!
    @IBOutlet weak var semestreTextField: UITextField!
    
    @IBOutlet weak var contraTextField: UITextField!
    @IBOutlet weak var verContraTextField: UITextField!
    
    @IBOutlet weak var iniciaButton: UIButton!
    @IBOutlet weak var creaButton: UIButton!
    
    var uniPicker = UIPickerView()
    var carreraPicker = UIPickerView()
    var semestrePicker = UIPickerView()
    
    var unis:[Universidades] = []
    
    let semestre=Array(1...10)
    let carrera=["Medicina","Ingeniería","Psicología"]
    
    
    override func viewDidLoad() {
        creaButton.layer.cornerRadius=7
        creaButton.layer.borderColor = CGColor.init(red: 1.2, green: 0, blue: 0, alpha: 1.5)
        creaButton.layer.borderWidth = 1.0
        super.viewDidLoad()
        let tap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        uniTextField.inputView=uniPicker
        carreraTextField.inputView=carreraPicker
        semestreTextField.inputView=semestrePicker
        
        uniPicker.delegate = self
        uniPicker.dataSource = self
        carreraPicker.delegate = self
        carreraPicker.dataSource = self
        semestrePicker.delegate = self
        semestrePicker.dataSource = self
        
        uniPicker.tag=1
        carreraPicker.tag=2
        semestrePicker.tag=3
        GetData()
        
    }
    @objc func DismissKeyBoard(){
        self.view.endEditing(true)
    }
    @IBAction func PostUsuario(_ sender: Any) {
        if nombreTextField.text != nil && contraTextField.text != nil && correoTextField.text != nil && uniTextField.text != nil && carreraTextField.text != nil && semestreTextField.text != nil{
            let newUser=User(name: nombreTextField.text!, password: contraTextField.text!, email: correoTextField.text!, universidad: uniTextField.text!, carrera: carreraTextField.text!, semestre: Int(semestreTextField.text!) ?? 0)
            
            
        }

    }
    @IBAction func LoginUsuario(_ sender: Any) {

    }
    
    
}
