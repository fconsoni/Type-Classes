//
//  Proof.swift
//  FunctionalSwift
//
//  Created by Franco Consoni on 5/11/18.
//  Copyright © 2018 codika. All rights reserved.
//

///A proof of implementing the MonadPlus TypeClass
enum Result<T>: MonadPlus {
  case success(T)
  case failure(Error)
  
  static func pure(_ val: T) -> Result<T> {
      return .success(val)
  }
  
  func getOrElse(_ defVal: T) -> T {
      switch self {
      case .success(let val):
          return val
      case _:
          return defVal
      }
  }
  
  func flatMap<B>(_ fx: @escaping (T) -> (Result<B>)) -> Result<B> {
      switch self {
      case .success(let val):
          return fx(val)
      case .failure(let error):
          return .failure(error)
      }
  }
  
  static func >>- <B>(rec: Result<T>, _ fx: @escaping (T) -> Result<B>) -> Result<B> {
    return rec.flatMap(fx)
  }
  
  func apply<B, APP>(_ app: APP) -> Result<B> where APP: Applicative, APP.T == (T) -> (B) {
      let fx = app.getOrElse(identity)
      return fMap(fx)
  }
  
  static func <*> <B, APP>(_ app: APP, _ rec: Result<T>) -> Result<B> where APP: Applicative, APP.T == (T) -> (B) {
    let fx = app.getOrElse(identity)
    return rec.fMap(fx)
  }
  
  func fMap<B>(_ fx: @escaping (T) -> B) -> Result<B> {
      switch self {
      case .success(let val):
          return .success(fx(val))
      case .failure(let error):
          return .failure(error)
      }
  }
  
  static func <~> <B>(functor: Result<T>, f: @escaping (T) -> B) -> Result<B> {
    return functor.fMap(f)
  }
  
  func filter(_ fx: @escaping (T) -> Bool) -> Result<T> {
    switch self {
    case .success(_):
      return self.fMap(fx).getOrElse(false) ? self : .failure(TestError())
    case _ :
      return self
    }
  }
}

final class TestError: Error {}


func sum(a: Int, b: Int) -> Int {
    return a + b
}

func half(a: Int) -> Result<Int> {
    return .pure(a/2)
}

func toS(_ a: Int) -> Result<String> {
  return .pure("Hi")
}

let plus = curry(sum)

/* The functional use of this tools. it's a chain of operations that reads from left to right */
let successOne: Result<(Int) -> Int> = .pure(1) >>- half >>- half <~> plus
let successTwo: Result<Int> = .pure(1) >>- half >>- half <~> plus <*> .pure(2)

let successThree: Result<Int> = Result.pure(2).apply(Result.pure(1).flatMap(half).flatMap(half).fMap(plus))
let successFour = Result.pure(1).filter{ $0 > 5 }.fMap(plus).fMap{ $0(1) }
  //Note that we need to declares the type of 'pure' when we are chaining methods

let successFive = (.pure(1) >>- half).flatMap(half)
  //Note that this is possible, but not recomended to do. Merging both worlds in this way it's not good
