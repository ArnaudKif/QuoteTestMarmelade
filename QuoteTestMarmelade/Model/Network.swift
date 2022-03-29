//
//  Network.swift
//  QuoteTestMarmelade
//
//  Created by arnaud kiefer on 29/03/2022.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://demotivation-quotes-api.herokuapp.com/")!)

}

