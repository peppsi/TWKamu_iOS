//
//  KamuExplorePresenter.swift
//  TWKamu
//
//  Created by Guilherme Coelho on 21/08/18.
//  Copyright (c) 2018 ThoughtWorks. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import PINRemoteImage

final class KamuExplorePresenter {
  
  // MARK: - Private properties -
  
  private unowned let view: KamuExploreViewInterface
  private let wireframe: KamuExploreWireframeInterface
  private let booksInteractor: KamuBooksInteractorInterface!

  // MARK: - Collection Itens
  
  let cellId = KamuConstants.Cells.book
  
  var cellItens:[KamuBook] = [] {
    didSet {
      view.updateCollectionView()
    }
  }
  
  // MARK: - Lifecycle -
  
  init(wireframe: KamuExploreWireframeInterface,
       view: KamuExploreViewInterface,
       booksInteractor: KamuBooksInteractorInterface) {
    self.wireframe = wireframe
    self.view = view
    self.booksInteractor = booksInteractor
  }
  
  // MARK: - Methods
  
  func viewWillAppear(animated: Bool) {
    booksInteractor.getBooks()
  }
  
}

// MARK: - Extensions -

extension KamuExplorePresenter: KamuBooksInteractorInterfaceResponse {
  
  func getBooksSuccess(books: [KamuBook]) {
    cellItens = books
  }
  
  func getBooksError(errorMessage: String) {
    
  }
  
}

extension KamuExplorePresenter: KamuExplorePresenterInterface {
  
  func clickInCell(index: IndexPath) {

  }
  
  func numberOfItens() -> Int {
    return cellItens.count
  }
  
  func cellForIndex(index: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: index) as? KamuBookCell else {
      return KamuBookCell()
    }
    
    let item = cellItens[index.row]
    
    let isBorrowed = ( item.user != nil && item.borrowDate != nil)
    
    let placeHolder = UIImage(named: "placeholderIcon")
    
    weak var weakPinCell = cell

    if let imgUrl = URL(string: item.imgUrl) {
      
      cell.imgBookCover.pin_setImage(from: imgUrl, placeholderImage:placeHolder,  completion: { (result) in
        if result.requestDuration > 0.25 {
          
          UIView.animate(withDuration: 0.3, animations: {
            weakPinCell?.alpha = 1
          })
        } else {
          weakPinCell?.alpha = 1
        }
      })
      cell.imgBookCover.contentMode = .scaleToFill
    } else {
      cell.imgBookCover.contentMode = .center
      cell.imgBookCover.image = placeHolder
    }
    
    cell.configureCellWith(title: item.title,
                           author: item.author,
                           isBorrowed: isBorrowed)
    
    return cell
  }
  
  func returnCellId() -> String {
    return self.cellId
  }
}
