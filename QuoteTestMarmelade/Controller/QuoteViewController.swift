//
//  QuoteViewController.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 28/03/2022.
//

import UIKit

class QuoteViewController: UIViewController {
    // MARK: - Class properties
private let viewModel = QuoteViewModel()

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
    @IBOutlet weak var nextButton: UIButton!

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.layer.addSublayer(gradient)
        resultView.layer.cornerRadius = 12.0

        viewModel.icon.bind { [weak self] smiley in
            self?.smileyImage.image = smiley
        }
        viewModel.buttonText.bind { [weak self] butText in
            self?.nextButton.setTitle("\(butText)", for: .normal)
        }
        viewModel.authorText.bind { [weak self] author in
            self?.authorLabel.text = author
        }
        viewModel.citationText.bind { [weak self] quote in
            self?.quoteLabel.text = quote
        }
        viewModel.progressText.bind { [weak self] progText in
            self?.progressNumber.text = progText
        }
        viewModel.progressSlider.bind { [weak self] slidText in
            self?.progressSlider.value = slidText
        }
        viewModel.progressRate.bind { [weak self] rate in
            if rate == 50 {
                self?.createAlert()
            }
            if rate == 100 {
                self?.toFinalView(self!.quoteButton)
            }
        }
    }

    // MARK: - IBActions
    @IBAction func nextQuoteButton(_ sender: Any) {
        viewModel.nextButtonTaped()
    }

    @IBAction func toFinalView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let finalPage = storyboard.instantiateViewController(withIdentifier: "FinalView") as! FinalViewController
        present(finalPage, animated: true)
    }

    /// Alert at 50% of progess : continue or restart ?
    func createAlert() {
        //TODO: - Finir de paramètrer l'affichage...
        let alertVC = UIAlertController(title: "Tu es à 50% des citations !", message: "Tu as bientôt fini !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Arrêter", style: .destructive, handler: {(alert: UIAlertAction!) in self.viewModel.resetProgress() }))
        alertVC.addAction(UIAlertAction(title: "Continuer", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}

