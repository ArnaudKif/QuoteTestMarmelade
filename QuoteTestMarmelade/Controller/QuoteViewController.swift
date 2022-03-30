//
//  QuoteViewController.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 28/03/2022.
//

import UIKit

class QuoteViewController: UIViewController {
    // MARK: - Class properties
    var progressRate: Int = 0

    // Setting of background gradient
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 0.953, green: 0.816, blue: 0.329, alpha: 1).cgColor,
            UIColor(red: 0.953, green: 0.804, blue: 0.329, alpha: 1).cgColor,
            UIColor(red: 0.945, green: 0.761, blue: 0.329, alpha: 1).cgColor,
            UIColor(red: 0.937, green: 0.694, blue: 0.325, alpha: 1).cgColor,
            UIColor(red: 0.929, green: 0.6, blue: 0.325, alpha: 1).cgColor,
            UIColor(red: 0.914, green: 0.478, blue: 0.322, alpha: 1).cgColor,
            UIColor(red: 0.898, green: 0.337, blue: 0.318, alpha: 1).cgColor
          ]
        gradient.locations = [0.07, 0.27, 0.43, 0.59, 0.73, 0.87, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.33, b: -1.17, c: 1.94, d: -0.65, tx: 0.41, ty: 1.49))
        gradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        gradient.position = view.center
        return gradient
    }()

    // MARK: - IBOutlets
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var smileyImage: UIImageView!
    @IBOutlet weak var progressNumber: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressNumber.text = "\(progressRate) % "
        endButton.isHidden = true
        gradientView.layer.addSublayer(gradient)
    }

    // MARK: - IBActions
    @IBAction func endbuttonTaped(_ sender: Any) {
        resetProgress()
        progressRate = 0
        quoteButton.isHidden = false
        endButton.isHidden = true
    }

    @IBAction func nextQuoteButton(_ sender: Any) {
        // TODO: - Lancer la prochaine citation et mettre à jour les labels
        nextQuote()
        progressRate += 10
        progressNumber.text = "\(progressRate) % "
        progressSlider.value = Float(progressRate)
        // print(progressRate)
        checkProgress()
    }

    // MARK: - Class methods
    /// Check the progress and update the smiley image
    func checkProgress() {
        if progressRate > 79 {
            self.smileyImage.image = UIImage(named: "smiley_awe.png")
        }
        if progressRate < 79 && progressRate > 39 {
            self.smileyImage.image = UIImage(named: "smiley_meh.png")
        }
        if progressRate < 39 {
            self.smileyImage.image = UIImage(named: "smiley_sick.png")
        }
        if progressRate == 50 {
            createAlert()
        }
        if progressRate == 100 {
            quoteButton.isHidden = true
            endButton.isHidden = false
            progressRate = -10
            createFinalAlert()
        }
    }

    /// Launches the network call, retrieves a quote and updates the quote display
    func nextQuote() {
        Network.shared.apollo.fetch(query: AllQueryQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                let countResult = graphQLResult.data?.quotes.count
                let randomIndex = Int.random(in: 0..<countResult!)
                guard let author = graphQLResult.data?.quotes[randomIndex].author,
                      let quote = graphQLResult.data?.quotes[randomIndex].quote
                else { return }
                DispatchQueue.main.async{
                    print("index : \(randomIndex) \n auteur : \(author)\n citation : \(quote)")
                    self?.authorLabel.text = author
                    self?.quoteLabel.text = quote
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    /// Restart the progress from the beginning
    func resetProgress() {
        progressRate = 0
        authorLabel.text = "Auteur"
        quoteLabel.text = "citation"
        smileyImage.image = UIImage(named: "smiley_sick.png")
        progressNumber.text = "0 % "
        progressSlider.value = 0.0
    }

    /// Alert at 50% of progess : continue or restart ?
    func createAlert() {
        //TODO: - Finir de paramètrer l'affichage...
        let alertVC = UIAlertController(title: "Tu es à 50% des citations !", message: "Tu as bientôt fini !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Arrêter", style: .destructive, handler: {(alert: UIAlertAction!) in self.resetProgress() }))
        alertVC.addAction(UIAlertAction(title: "Continuer", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    /// Final alert : Congrats
    func createFinalAlert() {
        let alertVC = UIAlertController(title: "🎉Tu es arrivé jusqu'à la fin!🎉", message: "J'espère que tu as appris beaucoup de choses.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Recommencer", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }


}

