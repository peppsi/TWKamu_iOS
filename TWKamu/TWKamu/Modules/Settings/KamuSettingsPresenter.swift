//
//  KamuSettingsPresenter.swift
//  TWKamu
//
//  Created by Guilherme Coelho on 22/08/18.
//  Copyright (c) 2018 ThoughtWorks. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class KamuSettingsPresenter {
  
  // MARK: - Private properties -
  
  private unowned let view: KamuSettingsViewInterface
  private let wireframe: KamuSettingsWireframeInterface
  
  // MARK: - TableView Items
  
  enum SettingsCellItem {
    
    case swtichItem(String)
    case labelItem(String)

    var cellId: String {
      switch self {
        
      case .labelItem:
        return KamuConstants.Cells.library
      case .swtichItem:
        return KamuConstants.Cells.switchCell

      }
    }
    
    var labelText: String {
      switch self {
        
      case .labelItem(let text):
        return text
        
      case .swtichItem(let text):
        return text
      }
    }
    
  }
  
  enum SettingsSectionItem {
    
    case notification
    case other
    
    var cellItens: [SettingsCellItem] {
      switch self {
        
      case .notification:
        
        return [.swtichItem(KamuStrings.Labels.settings_newBooksCell),
                .swtichItem(KamuStrings.Labels.settings_whishlistCell)]
        
      case .other:
        return [.labelItem(KamuStrings.Labels.settings_LogoutCell)]
      }
    }
    
    var name: String {
      switch self {
        
      case .notification:
        return "NOTIFICATION"
      case .other:
        return "OTHER"
        
      }
    }
  }
  
  private let sectionItens: [SettingsSectionItem] = [.notification, .other]
  
  // MARK: - Lifecycle -
  
  init(wireframe: KamuSettingsWireframeInterface,
       view: KamuSettingsViewInterface) {
    self.wireframe = wireframe
    self.view = view
  }
}

// MARK: - Extensions -

extension KamuSettingsPresenter: KamuSettingsPresenterInterface {
  
  func nameForSection(section: Int) -> String {
    return sectionItens[section].name
  }
  
  func configureCells(tableView: UITableView) -> UITableView {
    
    let id1 = KamuConstants.Cells.library
    let nib1 = UINib(nibName: id1, bundle: nil)
    
    let id2 = KamuConstants.Cells.switchCell
    let nib2 = UINib(nibName: id2, bundle: nil)
    
    tableView.register(nib1, forCellReuseIdentifier: id1)
    tableView.register(nib2, forCellReuseIdentifier: id2)

    return tableView
  }
  
  func totalItemsFor(section: Int) -> Int {
    let cellItens = sectionItens[section].cellItens
    return cellItens.count
  }
  
  func totalSections() -> Int {
    return sectionItens.count
  }
  
  func cellFor(index: IndexPath, tableView: UITableView) -> UITableViewCell {
    
    if sectionItens.isEmpty {
      return UITableViewCell()
    }
    
    let sectionItem = sectionItens[index.section]
    let cellId = sectionItem.cellItens[index.row].cellId

    if sectionItem == .notification {
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? KamuSettingsSwitchCell
        else {
          return UITableViewCell()
      }
      
      let text: String = sectionItem.cellItens[index.row].labelText
      
      cell.setLabel(text: text)
      
      return cell

    } else {
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? KamuLibraryCell
        else {
          return UITableViewCell()
      }
      
      let text = sectionItem.cellItens[index.row].labelText
      
      cell.setCity(city: text)

      return cell
    }
  }
  
  func clickInCellForRow(index: IndexPath) {
    
    let section = sectionItens[index.section]
    
    if section == .other && index.row == 0 {
      wireframe.navigate(to: .goToHome)
    }
    
  }
  
}
