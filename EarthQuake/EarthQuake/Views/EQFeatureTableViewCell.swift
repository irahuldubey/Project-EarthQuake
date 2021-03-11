//
//  EQFeatureTableViewCell.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import UIKit
import CorePackage

class EQFeatureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var magnitude: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpView() {
        titleLabel.textColor = ThemeEngine.label1Color
        statusLabel.textColor = ThemeEngine.label2Color
        magnitude.textColor = ThemeEngine.label3Color
    }
    
    func setupCell(with eqFeature: EQEarthQuake) {
        titleLabel.text = eqFeature.earthQuakeProperties.title
        statusLabel.text = "Status: \(eqFeature.earthQuakeProperties.status)"
        magnitude.text = "Magnitude: \(String(eqFeature.earthQuakeProperties.magnitude))"
    }
}
