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

    // MARK: - IBOutlets
    @IBOutlet var BackgroundView: UIView!
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

