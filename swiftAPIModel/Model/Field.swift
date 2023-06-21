//
//  Field.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/26/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
protocol Field{
    func getStringValue() -> String
    func getNumberValue() -> Double
    func getLabelValue()-> String
    func getTemplateID()-> String
}
protocol FieldTemplate {
    func getValuesList() -> [String]
    func getID() -> String
    func getLabel() -> String
}
