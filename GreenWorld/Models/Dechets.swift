//
//  Dechets.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct dechets: Identifiable {
    var id = UUID().uuidString
    var type: String
    var date: String
    var nombre_capacite: String
    var adresse: String
}
