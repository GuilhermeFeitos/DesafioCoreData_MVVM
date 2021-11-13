//
//  PeopleTableViewCell.swift
//  Desafio_CoreData
//
//  Created by Gui Feitosa on 12/11/21.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameAgeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(name: String, age: Int16) {
        nameAgeLabel.text = "\(name) - \(String(age))"
    }

}
