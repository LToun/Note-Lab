//
//  ViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 25/07/21.
//

import UIKit

class SignUp: UIViewController{

    

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    
    @IBOutlet weak var uniTextField: UITextField!
    @IBOutlet weak var carreraTextField: UITextField!
    @IBOutlet weak var semestreTextField: UITextField!
    
    @IBOutlet weak var contraTextField: UITextField!
    @IBOutlet weak var verContraTextField: UITextField!
    
    @IBOutlet weak var iniciaButton: UIButton!
    @IBOutlet weak var creaButton: UIButton!
    
    @IBOutlet weak var dominioEmail: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    
    var uniPicker = UIPickerView()
    var carreraPicker = UIPickerView()
    var semestrePicker = UIPickerView()
    
    var unis:[Universidades] = []
    
    let semestre=Array(1...10)
    let carrera=["Medicina","Ingeniería","Psicología"]
    
    
    override func viewDidLoad() {
        creaButton.layer.cornerRadius=7
        iniciaButton.layer.cornerRadius=7
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
        print("\(String(describing: correoTextField.text))\(String(describing: dominioEmail))")
        let vectorDatos:[String]=[nombreTextField.text!,contraTextField.text!,correoTextField.text!,uniTextField.text!,carreraTextField.text!,semestreTextField.text!,contraTextField.text!,verContraTextField.text!]
        
        if vectorDatos.contains("")==false && contraTextField.text == verContraTextField.text{
            let newUser=User(name: nombreTextField.text!, password: contraTextField.text!, email: correoTextField.text! + dominioEmail.text!, universidad: uniTextField.text!, carrera: carreraTextField.text!, semestre: Int(semestreTextField.text!) ?? 0)
            let createUser=CreateUserService()
            createUser.create(newUser) { resultUser in
                switch resultUser{
                case .success(let usr):
                    print("Creado: \(String(describing: usr?.name))")
                    self.responseLabel.textColor = .green
                    self.responseLabel.text="Bienvenido a Note Lab \(self.nombreTextField.text!), inicia sesión."
                    
                    self.creaButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0)
                    self.creaButton.layer.borderWidth = 0
                    self.iniciaButton.layer.borderColor = CGColor.init(red: 1.2, green: 0, blue: 0, alpha: 1.5)
                    self.iniciaButton.layer.borderWidth = 1.0
                    
                    self.nombreTextField.text=""
                    self.contraTextField.text=""
                    self.verContraTextField.text=""
                    self.correoTextField.text=""
                    self.uniTextField.text=""
                    self.carreraTextField.text=""
                    self.semestreTextField.text=""
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                    self.responseLabel.textColor = .red
                    self.responseLabel.text="Verifique sus datos"
                    
                }
            }
            
            
        }else {
            self.responseLabel.textColor = .red
            self.responseLabel.text="Verifique su contraseña y llene los campos"
        }

    }
    @IBAction func LoginUsuario(_ sender: Any) {

    }
    
    
}
