//
//  Template.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 5/28/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
protocol Template {
    func addField(f:Field?)
    func getID()->String
    func getFields()->[Field]
}
