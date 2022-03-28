//
//  QuoteViewController.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 28/03/2022.
//

import UIKit

class QuoteViewController: UIViewController {

    var isFirstPart: Bool = true
    var isSecondPart: Bool = false
    var isLastPart: Bool = false
    var progressRate: Int = 0

    @IBOutlet var BackgroundView: UIView!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var SmileyImage: UIImageView!
    @IBOutlet weak var progressNumber: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressNumber.text = "\(progressRate) % "
        endButton.isHidden = true
    }
    
    @IBAction func endbuttonTaped(_ sender: Any) {
        progressRate = 0
        quoteButton.isHidden = false
        endButton.isHidden = true
    }

    @IBAction func NextQuoteButton(_ sender: Any) {
// TODO: - Lancer la prochaine citation et mettre à jour les labels
        nextQuote()
        progressRate += 10
        progressNumber.text = "\(progressRate) % "
        progressSlider.value = Float(progressRate)
        print(progressRate)
       // TODO: - vérifier le taux et mettre à jour le smiley
        checkProgress()
    }

    func checkProgress() {
        if progressRate > 79 {
            self.SmileyImage.image = UIImage(named: "smiley_awe.png")
        }
        if progressRate < 79 && progressRate > 39 {
            self.SmileyImage.image = UIImage(named: "smiley_meh.png")
        }
        if progressRate < 39 {
            self.SmileyImage.image = UIImage(named: "smiley_sick.png")
        }
        if progressRate == 50 {
            //TODO: - Lancer une alerte
            createAlert()
        }
        if progressRate == 100 {
            // TODO: - Terminer la partie, changer le bouton sur finir et repartir à zéro
            quoteButton.isHidden = true
            endButton.isHidden = false
            progressRate = 0

        }
    }

    func nextQuote() {
        // TODO: - Lancer l'appel réseau et attribuer la nouvelles citations aux labels correspondants...

    }

    func createAlert() {
        //TODO: - Finir de paramètrer l'affichage...
        let alertVC = UIAlertController(title: "Tu es à 50% des citations !", message: "Tu as bientôt fini !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Arrêter", style: .destructive, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Continuer", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}

