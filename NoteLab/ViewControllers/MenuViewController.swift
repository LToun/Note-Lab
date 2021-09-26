//
//  MenuViewController.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import UIKit
import Foundation
import Vision
import VisionKit
class MenuViewController: UIViewController {

    private func configureDoc(){
        let scanningDocument = VNDocumentCameraViewController()
        scanningDocument.delegate=self
        self.present(scanningDocument, animated: true, completion: nil)
    }
    private let addBttn:UIButton={
        let button=UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .systemBlue
        let image=UIImage(systemName: "plus",
                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius=10
        button.layer.shadowOpacity=0.3
        button.layer.cornerRadius=30
        button.tag=2
        
        return button
    }()
    @IBOutlet weak var tableView: UITableView!
    var index:Int?
    var textVision:String=""
    var textPost:String=""
    var imagenes:[UIImage]=[]{
        didSet{
            for imagen in self.imagenes{
                self.reconoceTexto(image:imagen)
                self.textPost.append(self.textVision)
            }
            DispatchQueue.main.async {[unowned self] in
                performSegue(withIdentifier: "TextView", sender: self)
            }
            
        }
    }
    var notes:NotesDecoder?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addBttn)
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate=self
        tableView.dataSource=self
        addBttn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        load()
    }
    @objc func didTapButton(){
        configureDoc()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBttn.frame=CGRect(x: view.frame.size.width-70,
                             y: view.frame.size.height-70,
                             width: 60,
                             height: 60)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    */
@objc func load(){
        guard let url = URL(string: "https://boiling-spire-85241.herokuapp.com/apunte") else { return  }
        var req=URLRequest(url: url)
        req.httpMethod="GET"
        req.setValue(AmacaConfig.shared.apiToken, forHTTPHeaderField:"payloadToken")
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let data=data{
                print(data)
                do{
                    self.notes=try JSONDecoder().decode(NotesDecoder.self, from: data)
                    print(String(describing:self.notes?.apuntes.count))
                }catch {
                    print(String(describing: error))
                }

            }
        }.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let textViewController:TextViewController = segue.destination as! TextViewController
        if textPost .isEmpty{
            textViewController.apunte=self.notes?.apuntes[self.index!]
            textViewController.post=false
        }else{
            textViewController.apunte = Note(text: textPost, materia: "Materia", titulo: "Título")
            textViewController.post=true
        }
        
    }
    func reconoceTexto(image: UIImage?){
        guard let cgImage=image?.cgImage else{return}
//        handler
        let handler=VNImageRequestHandler(cgImage: cgImage, options: [:])
//        request
        let request=VNRecognizeTextRequest{request,error in
            guard let observations=request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                print(error?.localizedDescription as Any)
                return
            }
            var text=observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            text = text.replacingOccurrences(of: "- ", with: "")
            text = text.components(separatedBy: CharacterSet.decimalDigits).joined()
            
            self.textVision=text

            print(text)
        }
//        process request
        do{
            try handler.perform([request])
        }catch {
            print(error)
        }
    }
}
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index=indexPath.row
        performSegue(withIdentifier: "TextView", sender: self)
    }
}
extension MenuViewController: VNDocumentCameraViewControllerDelegate{
    func documentCameraViewController(_ controller:VNDocumentCameraViewController,didFinishWith scan:VNDocumentCameraScan) {
            for numPagina in 0..<scan.pageCount{
                let image=scan.imageOfPage(at: numPagina)
                self.imagenes.append(image)
            }
        controller.dismiss(animated: true, completion: nil)
    }
}
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.apuntes.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
//            if let userId=notes?.apuntes[indexPath.row]{
//                cell.autorLbl.text = String(describing:userId)
//            }else{
//                cell.autorLbl.text = "Place Holder"
//            }
            cell.autorLbl.text=notes?.apuntes[indexPath.row].author
            cell.tituloLbl.text=notes?.apuntes[indexPath.row].titulo
            cell.fechaLbl.text=notes?.apuntes[indexPath.row].date?.components(separatedBy: " ")[0]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
