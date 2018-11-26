//
//  Applicative.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

///Is the next step from Functor.
///
///Defines the 'apply' and 'pure' functions.
///
///Needs to implement the fMap function inherited from Functor, and the functions defined in the Container class.
///
///It defines the <*> operator as infix, but don't declare it, because produces an error of ambiguity.
///
///It's optional to define it.
protocol Applicative: Functor, Container {
    
  static func pure(_ val: T) -> Self
  
  func apply<B, APP: Applicative>(_ app: APP) -> Self where Self.T == B, APP.T == (T) -> (B)

  //static func <*> <B, APP: Applicative>(_ app: APP, _ rec: Self) -> Self where Self.T == B, APP.T == (T) -> (B)
}

///An infix way to do the apply Function
infix operator <*> : AdditionPrecedence
