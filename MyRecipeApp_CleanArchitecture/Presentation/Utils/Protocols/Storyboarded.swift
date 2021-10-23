//
//  Storyboarded.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import UIKit

/**
 # Storyboarded Protocol
 
 This protocol allows us to create ViewController layout (xib) in the main storyboard
 This is fine for our project because it has only one key feature.
 
 This implementation instantiate a view controller from story board given an identifier name
 **SOS! This name must be the same With the Class name.**
 */
protocol Storyboarded {
    static func instantiate()-> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate()-> Self {
        // get full name "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // loads Main story board (only one for our IMPL)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let className = fullName.components(separatedBy: ".")[safe: 1],
              let vc = storyboard.instantiateViewController(withIdentifier: className) as? Self
        else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard")
        }
        return vc
        
    }
}

