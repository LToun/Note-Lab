//
//  TableViewCell.swift
//  NoteLab
//
//  Created by Antonio Lara Navarrete on 23/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var carrera: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fechaLbl: UILabel!
    @IBOutlet weak var autorLbl: UILabel!
    @IBOutlet weak var tituloLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = view.frame.height / 2
        view.backgroundColor = .systemGray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
