//
//  SignInViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 05/08/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var iniciaButton: UIButton!


    @IBOutlet weak var creaButton: UIButton!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contraTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        iniciaButton.layer.cornerRadius=7
        iniciaButton.layer.borderColor = CGColor.init(red: 0, green: 1.2, blue: 0, alpha: 1.5)
        iniciaButton.layer.borderWidth = 1.0
        
        creaButton.layer.cornerRadius=7
        creaButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1.5)
        creaButton.layer.borderWidth = 1.0
        
        creaButton.backgroundColor = .systemGray2
        iniciaButton.backgroundColor = .systemGray2
        
        correoTextField.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        contraTextField.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        if AmacaConfig.shared.apiToken != nil{
            guard let url = URL(string: "https://boiling-spire-85241.herokuapp.com/trytoken") else { return  }
            var req=URLRequest(url: url)
            req.httpMethod="GET"
            req.setValue(AmacaConfig.shared.apiToken, forHTTPHeaderField: "payloadToken")
            URLSession.shared.dataTask(with: req) { data, response, error in
                if let data=data{
                    do{
                        let response=try JSONDecoder().decode(Message.self, from: data)
                        if response.message == "Good token"{
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "sesionIniciada", sender: self)
                            }
                        }
                        
                    }catch {
                        print("Credenciales incorrectas")
                    }
                }
            }.resume()
        }
        // Do any additional setup after loading the view.
    }
    @objc func DismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    @IBAction func Login(_ sender: Any) {
        let correo=correoTextField.text!
        let contra=contraTextField.text!
        let loginString=String(format: "%@:%@", correo, contra)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
//        Create Request
        guard let url = URL(string: "https://boiling-spire-85241.herokuapp.com/login") else { return  }
        var req=URLRequest(url: url)
        req.httpMethod="GET"
        req.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let data=data{
                do{
                    let tkn=try JSONDecoder().decode(Token.self, from: data)
                    AmacaConfig.shared.setApiToken(tkn.token!)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "sesionIniciada", sender: self)
                    }
                }catch {
                    print("Credenciales incorrectas")
                }
            }
        }.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
