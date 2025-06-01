//
//  Environment.swift
//  NetworkLayer
//
//  Created by Yan Cervantes on 26/11/24.
//

import SwiftUI

actor Environment {
  
  @MainActor
  static let shared: Environment = Environment()
  
  @MainActor
  public private(set) var fileConfig: String!
  @MainActor
  public private(set) var fileContent: NSDictionary!
  @MainActor
  public private(set) var environmentType: EnvironmentType!
  @MainActor
  public private(set) var attributes: [String: String] = [:]
  
  //MARK: Init
  
  @MainActor
  init() {
    setupEnvironment()
  }
  
  //MARK: Methods
  
  @MainActor
  func get(_ value: EnvironmentValue) -> String {
    if let value = attributes[value.rawValue] {
      return value
    }
    return ""
  }
  
  //MARK: Private Methods
  
  @MainActor
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
  
  @MainActor
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
