//
//  QuoteViewModel.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 08/04/2022.
//

import Foundation
import UIKit.UIImage

public class QuoteViewModel {

    var progressRate = Box(0)
    var isTheEnd: Bool = false
    let icon: Box<UIImage?> = Box(UIImage(named: "smiley_sick.png"))
    var buttonText = Box("CITATION SUIVANTE")
    var authorText = Box("Auteur")
    var citationText = Box("Citation")
    var progressText = Box("0 %")
    var progressSlider:Box<Float> = Box(0.0)

    // MARK: - Class methods
    /// Check the progress and update the smiley image
    func checkProgress() {
        if progressRate.value > 79 {
            self.icon.value = UIImage(named: "smiley_awe.png")
        } else if progressRate.value < 79 && progressRate.value > 39 {
            self.icon.value = UIImage(named: "smiley_meh.png")
        } else if progressRate.value < 39 {
            self.icon.value = UIImage(named: "smiley_sick.png")
        }
        if progressRate.value == 100 {
            isTheEnd = true
            buttonText.value = "FINIR"
            progressRate.value = -10
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
                    self?.authorText.value = author
                    self?.citationText.value = quote
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    /// Restart the progress from the beginning
    func resetProgress() {
        progressRate.value = 0
        authorText.value = "Auteur"
        citationText.value = "citation"
        icon.value = UIImage(named: "smiley_sick.png")
        progressText.value = "0 % "
        progressSlider.value = 0.0
        buttonText.value = "CITATION SUIVANTE"
        isTheEnd = false
    }

    func nextButtonTaped() {
        if isTheEnd {
            resetProgress()
            progressRate.value = 0
        } else {
        // TODO: - Lancer la prochaine citation et mettre à jour les labels
            nextQuote()
            progressRate.value += 10
            progressText.value = "\(progressRate.value) % "
            progressSlider.value = Float(progressRate.value)
        // print(progressRate)
            checkProgress()
        }
    }



}
