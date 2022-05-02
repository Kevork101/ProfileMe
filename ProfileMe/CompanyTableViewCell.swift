//
//  CompanyTableViewCell.swift
//  ProfileMe
//
//  Created by Kevork Atinizian on 5/2/22.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    // @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
