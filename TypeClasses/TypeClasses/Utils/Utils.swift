//
//  Utils.swift
//  TypeClasses
//
//  Created by Franco Consoni on 5/21/18.
//  Copyright © 2018 codika. All rights reserved.
//

import Foundation

func identity<T, B>(_ any: T) -> B {
    return any as! B
}

func curry<A,B,C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> (C) {
    return { a in { b in f(a,b) } }
}
