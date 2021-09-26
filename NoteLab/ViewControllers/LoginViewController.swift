//
//  SignInViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 05/08/21.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var iniciaButton: UIButton!
    @IBOutlet weak var creaButton: UIButton!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contraTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaButton.layer.cornerRadius=7
        iniciaButton.layer.borderColor = CGColor.init(red: 1.2, green: 0, blue: 0, alpha: 1.5)
        iniciaButton.layer.borderWidth = 1.0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: Any) {
        let correo=correoTextField.text!
        let contra=contraTextField.text!
        let loginString=String(format: "%@:%@", correo, contra)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
//        Create Request
        guard let url = URL(string: "http://127.0.0.1:5000/login") else { return  }
        var req=URLRequest(url: url)
        req.httpMethod="GET"
        req.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let data=data{
                do{
                    let tkn=try JSONDecoder().decode(Token.self, from: data)
                    print(tkn)
                    DispatchQueue.main.async {
                        
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
