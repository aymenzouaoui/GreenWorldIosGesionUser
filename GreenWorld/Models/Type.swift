//
//  Type.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//
import SwiftUI
struct Type: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var color: Color
    var detail: String
}

var items: [Type] = [
    Type(image: "Sans titre - 1", title: "Plastic", color: Color("Color"), detail: ""),
    Type(image: "waste", title: "e-waste", color: Color("Color1"), detail: ""),
    Type(image: "Sans titre - 3", title: "glasses",  color: Color("Color2"), detail: ""),
    Type(image: "Sans titre - 4", title: "Batterie", color: Color("Color3"), detail: ""),
]


