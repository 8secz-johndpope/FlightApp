//
//  L10N.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct L10N {
    static private var _currentLanguage: String?
    static private let _supportedLanguages: [String] = ["en", "pt"]
    static private let _defaultLanguage: String = "en"
    static private var _resourceManager: [LiteralObject] = []
    static private let _reportService: ReportService = DiContainer.resolve()
    
    static func getCurrentLanguage() -> String {
        if(_currentLanguage == nil) {
            _setLanguage()
        }
        
        return _currentLanguage!
    }
    
    static func localize(key: String) -> String {
        let value = _getResourceManager().first(where: { $0.key == key })
        return value?.translated ?? ""
    }
    
    static func _getResourceManager() -> [LiteralObject] {
        if(_resourceManager.isEmpty) {
            _setLanguage()
            _loadJsonString()
        }
        
        return _resourceManager
    }
    
    static func _setLanguage() {
        let deviceLanguage = Locale.current.languageCode
        _currentLanguage = _supportedLanguages.first(where: { $0 == deviceLanguage }) ?? _defaultLanguage
    }
    
    static func _loadJsonString() {
        if let path = Bundle.main.path(forResource: _currentLanguage, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                for (key, value) in jsonResult {
                    _resourceManager.append(LiteralObject(key: key as! String, translated: value as! String))
                }
          } catch let error {
                _reportService.sendError(error: error, message: "Error loading json")
            }
        }
    }
}
