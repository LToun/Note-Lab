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
    
    let semestre=Array(1...10)
    var unis:[Universidades] = []
    let carrera=[
    "Facultad de Arquitectura"
    ,"Facultad de Artes y Diseño"
    ,"Facultad de Ciencias"
    ,"Facultad de Ciencias Políticas y Sociales"
    ,"Facultad de Contaduría y Administración"
    ,"Facultad de Derecho"
    ,"Facultad de Economía"
    ,"Facultad de Estudios Superiores (FES) Acatlán"
    ,"Facultad de Estudios Superiores (FES) Aragón"
    ,"Facultad de Estudios Superiores (FES) Cuautitlán"
    ,"Facultad de Estudios Superiores (FES) Iztacala"
    ,"Facultad de Estudios Superiores (FES) Zaragoza"
    ,"Facultad de Filosofía y Letras"
    ,"Facultad de Ingeniería"
    ,"Facultad de Medicina"
    ,"Facultad de Medicina Veterinaria y Zootecnia"
    ,"Facultad de Música"
    ,"Facultad de Odontología"
    ,"Facultad de Psicología"
    ,"Facultad de Química"]
    
    
    override func viewDidLoad() {
        creaButton.layer.cornerRadius=7
        creaButton.layer.borderColor = CGColor.init(red: 0, green: 1.2, blue: 0, alpha: 1.5)
        creaButton.layer.borderWidth = 1.0
        
        iniciaButton.layer.cornerRadius=7
        iniciaButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1.5)
        iniciaButton.layer.borderWidth = 1.0
        
        iniciaButton.backgroundColor = .systemGray2
        creaButton.backgroundColor = .systemGray2

        super.viewDidLoad()
        let tap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        
        uniTextField.attributedPlaceholder = NSAttributedString(string: "Universidad", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        carreraTextField.attributedPlaceholder = NSAttributedString(string: "Carrera", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        semestreTextField.attributedPlaceholder = NSAttributedString(string: "Semestre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        nombreTextField.attributedPlaceholder = NSAttributedString(string: "Nombre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        correoTextField.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        contraTextField.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        verContraTextField.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
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
    public func BetaUser(){
        self.responseLabel.textColor = .red
        self.responseLabel.text="Solo alumnos de la UNAM tienen acceso a la beta."
    }
    @IBAction func PostUsuario(_ sender: Any) {
        print("\(String(describing: correoTextField.text))\(String(describing: dominioEmail))")
        let vectorDatos:[String]=[nombreTextField.text!,contraTextField.text!,correoTextField.text!,uniTextField.text!,carreraTextField.text!,semestreTextField.text!,contraTextField.text!,verContraTextField.text!]
        
        if vectorDatos.contains("")==false && contraTextField.text == verContraTextField.text{
            if dominioEmail.text=="unam.mx"{
                let newUser=User(name: nombreTextField.text!, password: contraTextField.text!, email: correoTextField.text! + dominioEmail.text!, universidad: uniTextField.text!, carrera: carreraTextField.text!, semestre: Int(semestreTextField.text!) ?? 0)
                let createUser=CreateUserService()
                createUser.create(newUser) { resultUser in
                    switch resultUser{
                    case .success(let usr):
                        print("Creado: \(String(describing: usr?.name))")
                        self.responseLabel.textColor = .green
                        self.responseLabel.text="Bienvenido a Note Lab \(self.nombreTextField.text!), inicia sesión."
                        
                        self.creaButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1.5)
                        self.creaButton.layer.borderWidth = 1.0
                        self.iniciaButton.layer.borderColor = CGColor.init(red: 0, green: 1.2, blue: 0, alpha: 1.5)
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
            }else{
                self.uniTextField.text=""
                self.responseLabel.text="😡"
            }
    
        }else {
            self.responseLabel.textColor = .red
            self.responseLabel.text="Verifique su contraseña y llene los campos"
        }

    }
    @IBAction func LoginUsuario(_ sender: Any) {

    }
    
    
}
