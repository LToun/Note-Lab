//
//  TextViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import UIKit
class TextViewController: UIViewController  {
    
    @IBOutlet weak var regresaBtn: UIButton!
    @IBOutlet weak var authorFechaLbl: UILabel!
    
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var tituloTF: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var materiaLbl: UILabel!
    @IBOutlet weak var materialTF: UITextField!
    @IBOutlet weak var textView: UITextView!
    var apunte:Note?
    var post:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        guard let pist=post else {return}
        print(pist)
        if pist{//true
            tituloLbl.isHidden = pist
            materiaLbl.isHidden = pist
            tituloTF.isHidden = !pist
            materialTF.isHidden = !pist
            postButton.isEnabled = pist
            textView.isEditable = pist
            tituloTF.text=apunte?.titulo
            materialTF.text=apunte?.materia
            
            
        }else{//No habra post false
            tituloLbl.isHidden = pist
            materiaLbl.isHidden = pist
            tituloTF.isHidden = !pist
            materialTF.isHidden = !pist
            postButton.isHidden = !pist
            textView.isEditable = pist
            textView.isSelectable=true
            
            materiaLbl.text=apunte?.materia
            tituloLbl.text=apunte?.titulo
        }
        textView.text=apunte?.text
        authorFechaLbl.text="\(apunte?.author ?? "Tú"), \(apunte?.date?.components(separatedBy: " ")[0] ?? "")"

        // Do any additional setup after loading the view.
    }
    @IBAction func Post(_ sender: Any) {
        let postService=CreatePostService()
        postService.create(Note(text: textView.text, materia: materialTF.text ?? "Materia perdida", titulo: tituloTF.text ?? "No hacemos magia")) { resul in
            switch resul{
                case .success(let note):
                    print("Apunte creado: \(String(describing: note?.titulo!))")
                    DispatchQueue.main.async {[unowned self] in
                        performSegue(withIdentifier: "MapaSegue", sender: self)
                    }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    @objc func DismissKeyBoard(){
        self.view.endEditing(true)
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
