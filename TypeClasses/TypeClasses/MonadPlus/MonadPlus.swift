//
//  Monad.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

///The next step from Monad.
///
///In order to implement the MonadPlus TypeClass, the 'filter' function need to be implemented,
///also the inherited functions from Container, Functor, Applicative and Monad.
protocol MonadPlus: Monad {
  func filter(_ fx: @escaping (T) -> Bool) -> Self
}
