//
//  Environment.swift
//  NetworkLayer
//
//  Created by Yan Cervantes on 26/11/24.
//

import SwiftUI

final class Environment {
    
  public private(set) var fileConfig: String!
  public private(set) var fileContent: NSDictionary!
  public private(set) var environmentType: EnvironmentType!
  public private(set) var attributes: [String: String] = [:]
  
  //MARK: Init
  
  init() {
    setupEnvironment()
  }
  
  //MARK: Methods
  
  func get(_ value: EnvironmentValue) -> String {
    if let value = attributes[value.rawValue] {
      return value
    }
    return ""
  }
  
  //MARK: Private Methods
  
  private func setupEnvironment() {
    let env = getKeyEnv()
    environmentType = env
    fileConfig = Bundle.main.path(forResource: "Env", ofType: "plist")
    fileContent = NSDictionary(contentsOfFile: fileConfig)
    if let atributes = fileContent[env.rawValue] as? [String: String] {
      self.attributes = atributes
    }
  }
  
  // MARK: Private Methods
  
  private func getKeyEnv() -> EnvironmentType {
     #if Store
    debugPrint("Environment PRODUCTION")
    return .Store
     #elseif QA
    debugPrint("Environment UAT - QA")
    return .QA
     #else
    debugPrint("Environment STAGE")
    return .Stage
     #endif
  }
  
  enum EnvironmentValue: String {
    case baseUrl
  }
  
  enum EnvironmentType: String {
    case Store
    case QA
    case Stage
  }
}
