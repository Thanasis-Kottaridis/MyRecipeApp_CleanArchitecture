//
//  InjectModules.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

/**
    We create a NetworkProviderKey class that is responsible for instantiating NetworkProvider Key
    and conforms Injection Key protocol
 */
private struct NetworkProviderKey: InjectionKey{
    static var currentValue: NetworkProviding = NetworkProvider()
}

/**
    For every Injected Value we have to create a computed property of its Provider in order to have access on getting and setting method
    **Self:** Here referring to the working Extension
    **Provider.self:** here provides Provider type (that conforms InjectionKey) to InjectedValues key subscript.
 */
extension InjectedValues {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self]}
        set { Self[NetworkProviderKey.self] = newValue }
    }
}
