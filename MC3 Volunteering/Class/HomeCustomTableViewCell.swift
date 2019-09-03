//
//  HomeCustomTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class HomeCustomTableViewCell: UITableViewCell {
    
    var eventId:String?
    
    @IBOutlet weak var tvHomeJumlahTemanLabel: UILabel!
    @IBOutlet weak var tvHomeLokasiDanTanggalLabel: UILabel!
    @IBOutlet weak var tvHomeNamaAcaraLabel: UILabel!
    @IBOutlet weak var tableViewCellHomeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTableCell(model: CKRecord){
        
        tvHomeNamaAcaraLabel.text = model[RemoteEvents.name] as! String
        
        tvHomeJumlahTemanLabel.text = "30"
        
        tvHomeLokasiDanTanggalLabel.text = "\(model[RemoteEvents.location] as! String), \(model[RemoteEvents.time] as! String)"
        
        if let asset = model[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                    self.tableViewCellHomeImage.image = UIImage(data: data)
            }
        }
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
