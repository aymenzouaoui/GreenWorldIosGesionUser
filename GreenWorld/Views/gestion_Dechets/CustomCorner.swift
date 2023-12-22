//
//  CustomCorner.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct CustomCorner: Shape {
    var corner: UIRectCorner
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}
