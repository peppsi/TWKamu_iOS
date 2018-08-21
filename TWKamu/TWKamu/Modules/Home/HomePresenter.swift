//
//  HomePresenter.swift
//  TWKamu
//
//  Created by Guilherme Coelho on 13/08/18.
//  Copyright (c) 2018 ThoughtWorks. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class HomePresenter {
  
  // MARK: - Private properties -
  
  private unowned let view: HomeViewInterface
  private let wireframe: HomeWireframeInterface
  
  private var userEmail:String = "" {
    didSet {
      updateLoginStatus()
    }
  }
  
  private var userPassword:String = "" {
    didSet {
      updateLoginStatus()
    }
  }
  
  // MARK: - Lifecycle -
  
  init(wireframe: HomeWireframeInterface,
       view: HomeViewInterface) {
    self.wireframe = wireframe
    self.view = view
  }
  
  // MARK: - Methods
  
  private func updateLoginStatus() {
    
    let emailIsValid = userEmail.isEmailValid
    let passwordIsValid = userPassword.count >= self.minimumPasswordSize
    let enableLogin = emailIsValid && passwordIsValid
    
    view.loginButtonIs(enabled: enableLogin)
  }
  
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterInterface {
  
  // Properties
  
  var minimumPasswordSize: Int {
    return 6
  }
  
  // Actions
  
  func startIsPressed() {
    wireframe.navigate(to: .goToLibraries)
  }
  
  func tfEmailIsChanged(email: String) {
    userEmail = email
  }
  
  func tfPasswordIsChanged(password: String) {
    userPassword = password

  }
  
  // Notification
  
  func showErrorMessage(message: String) {
    wireframe.navigate(to: .showError(message))
  }
  
  // Configuration

  func configureWelcomeLabel() -> String {
    return KamuStrings.Labels.home_welcome
  }
  
  func configureStartButton() -> String {
    return KamuStrings.Buttons.login
  }
  
}
