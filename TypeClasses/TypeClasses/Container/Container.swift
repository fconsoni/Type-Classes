//
//  Container.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

///Is the generalization of the idea of having a wrapped value.
///
///May define functions to treat with it.
protocol Container {
    associatedtype T
    
    func getOrElse(_ defVal: T) -> T
}
