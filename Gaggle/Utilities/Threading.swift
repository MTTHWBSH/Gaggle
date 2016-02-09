//
//  Threading.swift
//  Gaggle
//
//  Created by Matthew Bush on 2/8/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation

infix operator ~> {}

func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure:       (result: R) -> ())
{
    dispatch_async(queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), {
            mainClosure(result: result)
        })
    }
}

private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)
