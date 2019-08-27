//
//  HomeCustomTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class HomeCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var tvHomeJumlahTemanLabel: UILabel!
    @IBOutlet weak var tvHomeLokasiDanTanggalLabel: UILabel!
    @IBOutlet weak var tvHomeNamaAcaraLabel: UILabel!
    @IBOutlet weak var tableViewCellHomeImage: UIImageView!
    @IBOutlet weak var tableViewCellHomeJoinButton: RoundButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTableCell(model: EventModel){
        tvHomeLokasiDanTanggalLabel.text = "\(model.eventLocation), \(model.eventTime)"
        tableViewCellHomeImage.image = model.eventPhoto
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
