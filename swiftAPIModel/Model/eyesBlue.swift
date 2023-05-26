//
//  eyesBlue.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class eyesBlue:Rule{
    override func isSatisfiedBy(field: Field) -> Bool{
        if field.eyesColor == "Blue"{
            return true
        }
    return false
    }
}
