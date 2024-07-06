//
//  GridView.swift
//  TicTacToe
//
//  Created by Yutong Sun on 1/30/24.
//

import UIKit

class GridView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    override func draw(_ rect: CGRect)
    {
        let path = UIBezierPath()
        let lineWidth: CGFloat = 10.0
        path.lineWidth = lineWidth
        let horizontalLineSpacing = rect.height / 3
        let verticalLineSpacing = rect.width / 3
        
        for i in 1...2 {
            let xPosition = CGFloat(i) * verticalLineSpacing
            path.move(to: CGPoint(x: xPosition, y: 0))
            path.addLine(to: CGPoint(x: xPosition, y: rect.height))
        }
        for i in 1...2 {
            let yPosition = CGFloat(i) * horizontalLineSpacing
            path.move(to: CGPoint(x: 0, y: yPosition))
            path.addLine(to: CGPoint(x: rect.width, y: yPosition))
        }

        UIColor.purple.setStroke()
        path.stroke()
    }

}
