//
//  Monad.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

///The next step from Applicative.
///
///In order to implement the Monad TypeClass, the 'flatMap' function need to be implemented,
///also the inherited functions from Container, Functor and Applicative.
///
///It defines the >>- operator as infix, but don't declare it, because produces an error of ambiguity.
///
///It's optional to define it.
protocol Monad: Applicative {
  func flatMap<B>(_ fx: @escaping (T) -> (Self)) -> Self where Self.T == B
  
  //static func >>- <B>(rec: Self, _ fx: @escaping (Self.T) -> Self) -> Self where Self.T == B
}

///An infix way to do the flatMap Function
infix operator >>- : AdditionPrecedence
