//
//  Product.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 27/11/2023.
//

import SwiftUI

struct Product: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            
            Spacer()
            Text("Product View")
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
