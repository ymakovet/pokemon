//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Properties
    
    private let presenter: PokemonListPresenter
    
    private var collectionColumns: CGFloat = 4
    
    // MARK: - Lifecycle
    
    init(presenter: PokemonListPresenter) {
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

        title = "List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(didTapRightButton))
        setupCollectionView()
        presenter.handleViewDidLoadEvent()
    }
    
    // MARK: - Internal methods

    // MARK: - Private methods
    
    private func setupCollectionView() {
        
        collectionViewFlowLayout.scrollDirection = .vertical
        
        collectionViewFlowLayout.minimumInteritemSpacing = 2
        collectionViewFlowLayout.minimumLineSpacing = 2
        
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 8, left: 2, bottom: 8, right: 2)
        
        setCollectionItemSize()
    }
    
    private func setCollectionItemSize() {
        
        let itemWidth = (UIScreen.main.bounds.width - (collectionColumns * 2 + 2)) / collectionColumns
        let itemHeight = itemWidth * 1.5
        collectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    @objc private func didTapRightButton() {
        
        if collectionColumns > 2 {
            collectionColumns -= 1
        } else {
            collectionColumns = 4
        }
        
        collectionView.performBatchUpdates({
            collectionView.collectionViewLayout.invalidateLayout()
            
            setCollectionItemSize()
            
        }, completion: nil)

    }
}
