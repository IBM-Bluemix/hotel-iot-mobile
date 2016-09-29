//
//  ReservationTableViewCell.swift
//  cielo
//
//  Created by Anton McConville on 2016-09-28.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
