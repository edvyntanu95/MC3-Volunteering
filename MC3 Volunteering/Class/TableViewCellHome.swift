//
//  TableViewCellHome.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class TableViewCellHome: UITableViewCell {
    
    @IBOutlet weak var cellAtTableViewCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableViewCellHome {
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>(_ dataSourceDelegate: D, forRow row: Int)
    {
        cellAtTableViewCell.delegate = dataSourceDelegate
        cellAtTableViewCell.dataSource = dataSourceDelegate
        
        cellAtTableViewCell.reloadData()
    }
}

