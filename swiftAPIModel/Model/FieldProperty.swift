//
//  FieldProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
protocol FieldProperty {
    func getValuesList() -> [String]
    func getID() -> String
    func getLabel() -> String
}
