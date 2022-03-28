//
//  QuoteViewController.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 28/03/2022.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet var BackgroundView: UIView!

    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var SmileyImage: UIImageView!
    @IBOutlet weak var progressNumber: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var progressSlider: UISlider!


    override func viewDidLoad() {
        super.viewDidLoad()
//        initView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NextQuoteButton(_ sender: Any) {
    }

    func initView() {
//        let layer0 = CAGradientLayer()
//        layer0.colors = [
//          UIColor(red: 0.953, green: 0.816, blue: 0.329, alpha: 1).cgColor,
//          UIColor(red: 0.953, green: 0.804, blue: 0.329, alpha: 1).cgColor,
//          UIColor(red: 0.945, green: 0.761, blue: 0.329, alpha: 1).cgColor,
//          UIColor(red: 0.937, green: 0.694, blue: 0.325, alpha: 1).cgColor,
//          UIColor(red: 0.929, green: 0.6, blue: 0.325, alpha: 1).cgColor,
//          UIColor(red: 0.914, green: 0.478, blue: 0.322, alpha: 1).cgColor,
//          UIColor(red: 0.898, green: 0.337, blue: 0.318, alpha: 1).cgColor
//        ]
//        layer0.locations = [0.07, 0.27, 0.43, 0.59, 0.73, 0.87, 1]
//        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
//        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
//        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.33, b: -1.17, c: 1.94, d: -0.65, tx: 0.41, ty: 1.49))
//        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//        layer0.position = BackgroundView.center
//        BackgroundView.layer.addSublayer(layer0)

    }




}
