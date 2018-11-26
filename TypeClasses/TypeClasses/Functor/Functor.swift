//
//  Functor.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

///Is the generalization of the idea of mapping the wrapped value.
///
///The way of mapping may be similar, but the fMap function stills abstract.
///
///Also defines the <~> operator, that's an infix way to do the fMap Function
protocol Functor {
  associatedtype T

  func fMap<B>(_ fx: @escaping (T) -> B) -> Self where Self.T == B
  
  static func <~> <B>(_ functor: Self, _ f: @escaping (T) -> B) -> Self where Self.T == B
}

///An infix way to do the fMap Function
infix operator <~> : AdditionPrecedence
