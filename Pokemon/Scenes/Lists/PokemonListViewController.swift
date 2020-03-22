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
    
    private(set) var loadingView: UIView!
    private(set) var activity: UIActivityIndicatorView!
    
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
        
        setupNavBar()
        setupCollectionView()
        presenter.handleViewDidLoadEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLoadingView()
    }
    
    // MARK: - Private methods
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold),
                                                                   NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "collection_layout_4"), style: .plain, target: self, action: #selector(didTapRightButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor =  UIColor(red:0.94, green:0.33, blue:0.31, alpha:1.00)
        
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
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
    
    private func setupLoadingView() {
        
        loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = loadingView.center
        
        loadingView.addSubview(activity)
        view.addSubview(loadingView)
        
        loadingView.isHidden = true
    }
    
    @objc private func didTapRightButton() {
        
        if collectionColumns > 2 {
            collectionColumns -= 1
        } else {
            collectionColumns = 4
        }
        navigationItem.rightBarButtonItem?.image = UIImage(named: "collection_layout_\(collectionColumns)")
        collectionView.performBatchUpdates({
            collectionView.collectionViewLayout.invalidateLayout()
            
            setCollectionItemSize()
            
        }, completion: nil)
        
    }
}
