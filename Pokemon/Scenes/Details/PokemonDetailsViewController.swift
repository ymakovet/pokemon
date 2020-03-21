//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    // MARK: - Properties
    
    let presenter: PokemonDetailsPresenter
    
    // MARK: - Lifecycle
    
    init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.fillContent()
    }

}
