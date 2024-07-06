//
//  ViewController.swift
//  TicTacToe
//
//  Created by Yutong Sun on 1/30/24.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var GridView: GridView!
    
    @IBOutlet var Squares: [UIView]!
    @IBOutlet var Square0: UIView!
    @IBOutlet var Square1: UIView!
    @IBOutlet var Square2: UIView!
    @IBOutlet var Square3: UIView!
    @IBOutlet var Square4: UIView!
    @IBOutlet var Square5: UIView!
    @IBOutlet var Square6: UIView!
    @IBOutlet var Square7: UIView!
    @IBOutlet var Square8: UIView!
    
    @IBOutlet var O: UILabel!
    @IBOutlet var X: UILabel!
    
    @IBOutlet var InfoView: InfoView!
    @IBOutlet var Info: UILabel!
    @IBOutlet var OK: UIButton!
    
    @IBOutlet var InfoButton: UIButton!
    
    var X_center = CGPoint()
    var O_center = CGPoint()
    var player = "X"
    
    let grid: Grid = Grid()
    var grids_view: [UILabel] = []
    let shapeLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, square) in self.Squares.enumerated() {
            square.frame.origin.x = CGFloat((index % 3) * (15+121))
            square.frame.origin.y = 246 + CGFloat((index / 3) * (15 + 121))
            square.frame.size.width = CGFloat(121)
            square.frame.size.height = CGFloat(121)
        }
        
        self.X.isUserInteractionEnabled = true
        self.O.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        
        self.X.alpha = 0.5
        self.O.alpha = 0.5
        X_center = self.X.center
        O_center = self.O.center
        self.InfoView.center = CGPoint(x:self.view.center.x, y:-500)
        self.InfoView.Info.text = "Get 3 in a row to win!"
        InfoButton.addTarget(self, action: #selector(showInfo), for: UIControl.Event.touchUpInside)
        OK.addTarget(self, action: #selector(nextGame), for: UIControl.Event.touchUpInside)
        
        if player == "X" {
            self.O.isUserInteractionEnabled = false
            self.X.alpha = 1
        } else {
            self.X.isUserInteractionEnabled = false
            self.O.alpha = 1
        }
        setupGestureRecognizers()
    }
    private func setupGestureRecognizers() {
        let panGestureX = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGestureX.delegate = self
        self.X.addGestureRecognizer(panGestureX)

        let panGestureO = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGestureO.delegate = self
        self.O.addGestureRecognizer(panGestureO)
    }
    
    @IBAction func showInfo(_ sender: UIButton) {
        self.view.bringSubviewToFront(self.InfoView)
        UIView.animate(withDuration: 0.5) {
            self.InfoView.center = CGPoint(x:self.view.center.x, y:self.view.center.y)
        }
    }
    
    @IBAction func nextGame(_ sender: UIButton) {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.InfoView.center = CGPoint(x: self.view.center.x, y: 1000)
        }
        animator.addCompletion { position in
            self.InfoView.center = CGPoint(x: self.view.center.x, y: -1000)
            if self.grid.state != State.continuation {
                self.InfoView.Info.text = "Get 3 in a row to win!"
                self.player = "X"
                self.shapeLayer.removeFromSuperlayer()
                self.O.isUserInteractionEnabled = false
                self.X.alpha = 1
                self.O.alpha = 0.5
                self.grid.resetGame()
                self.grids_view.forEach { $0.removeFromSuperview() }
                self.grids_view.removeAll()
            }
            self.view.sendSubviewToBack(self.InfoView)
        }
        animator.startAnimation()
    }


    private func resetUIForNewGame() {
        self.shapeLayer.removeFromSuperlayer()
                self.O.isUserInteractionEnabled = false
        self.X.isUserInteractionEnabled = true
        self.X.alpha = 1.0
        self.O.alpha = 0.5
    }

    private func clearGridsView() {
        // Remove all player moves from the view
        self.grids_view.forEach { $0.removeFromSuperview() }
        self.grids_view.removeAll()
    }

    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        
        let translation = gestureRecognizer.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        gestureRecognizer.setTranslation(.zero, in: self.view)
        
        if gestureRecognizer.state == .ended {
            handleGestureEnd(for: view)
        }
    }
    private func handleGestureEnd(for view: UIView) {
        let isXLabel = view == self.X
        let currentPlayerSymbol = isXLabel ? "X" : "O"

        guard let closestSquareIndex = findClosestSquare(to: view) else {
            view.center = isXLabel ? X_center : O_center
            return
        }

        if grid.isSquareEmpty(square: closestSquareIndex) {
            let newLabel = createNewLabel(label: isXLabel ? X : O, square_key: closestSquareIndex)
            self.view.addSubview(newLabel)
            grids_view.append(newLabel)
            grid.updateGrids(for: currentPlayerSymbol, with: closestSquareIndex)
            checkAndUpdateGameState(for: currentPlayerSymbol)
        }
        view.center = isXLabel ? X_center : O_center
        
    }
    
    private func createNewLabel(label: UILabel, square_key: Int) -> UILabel {
        let newLabel = UILabel(frame : CGRect(x: 0, y: 0, width: label.frame.width, height: label.frame.height))
        newLabel.backgroundColor = label.backgroundColor
        newLabel.text = label.text
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.center = Squares[square_key].center
        newLabel.layer.borderWidth = 1
        newLabel.layer.borderColor = UIColor.white.cgColor
        return newLabel
    }
    
    private func findClosestSquare(to view: UIView) -> Int? {
        let squaresDistances = Squares.enumerated().map { (index, square) in
            (index, distance(from: view.center, to: square.center))
        }
        return squaresDistances.min { $0.1 < $1.1 }?.0
    }
    
    private func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointB.x - pointA.x, 2) + pow(pointB.y - pointA.y, 2))
    }
    
    private func checkAndUpdateGameState(for player: String) {
        let isGameOver = grid.checkState(for: player)

        if isGameOver {
            displayEndGameMessage(for: player)
        } else {
            changeTurn(to: player == "X" ? "O" : "X")
        }
    }
    
    private func displayEndGameMessage(for player: String) {
        let message: String
        let winnerGrids: [Int]

        switch grid.state {
        case .X_win:
            message = "Congratulations, X wins!"
            winnerGrids = grid.winnerGrids(grids: grid.X_grids)
            drawWinnerLine(winnerGrids: winnerGrids)
        case .O_win:
            message = "Congratulations, O wins!"
            winnerGrids = grid.winnerGrids(grids: grid.O_grids)
            drawWinnerLine(winnerGrids: winnerGrids)
        case .Tie:
            message = "It's a tie!"
        default:
            message = "Game Over!"
        }

        self.view.bringSubviewToFront(self.InfoView)
        UIView.animate(withDuration: 0.5, delay: grid.state == .Tie ? 0 : 2) {
            self.InfoView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            self.InfoView.Info.text = message
        }
    }
    
    private func drawWinnerLine(winnerGrids: [Int]) {
        guard winnerGrids.count == 3 else { return }

        let path = UIBezierPath()
        path.move(to: Squares[winnerGrids[0]].center)
        path.addLine(to: Squares[winnerGrids[1]].center)
        path.addLine(to: Squares[winnerGrids[2]].center)

        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = path.cgPath

        view.layer.addSublayer(shapeLayer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        
        shapeLayer.add(animation, forKey: "line")
        
    }

    private func changeTurn(to newPlayer: String) {
        player = newPlayer

        if player == "X" {
            self.X.isUserInteractionEnabled = true
            self.O.isUserInteractionEnabled = false
            self.X.alpha = 1.0
            self.O.alpha = 0.5
        } else {
            self.X.isUserInteractionEnabled = false
            self.O.isUserInteractionEnabled = true
            self.X.alpha = 0.5
            self.O.alpha = 1.0
        }
    }
}

