//
//  InfoView.swift
//  TicTacToe
//
//  Created by Yutong Sun on 1/31/24.
//

import UIKit

class InfoView: UIView {
    @IBOutlet var Info: UILabel!
    @IBOutlet var OK: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 30.0
        layer.borderWidth = 3
        layer.borderColor = UIColor.blue.cgColor
        layer.backgroundColor = UIColor.red.cgColor
        self.alpha = 1

        Info.layer.cornerRadius = 20.0
        Info.layer.masksToBounds = true
        OK.layer.cornerRadius = 20.0
        OK.layer.masksToBounds = true

        Info.layer.backgroundColor = UIColor.systemIndigo.cgColor
        Info.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        Info.layer.borderWidth = 2.5
        OK.layer.backgroundColor = UIColor.systemIndigo.cgColor
        OK.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        OK.layer.borderWidth = 2.5
        }
}
