//
//  ItemView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct ItemView: View {
    var item: Type
    @State private var isDetailActive = false
    var body: some View {
        VStack(spacing: 12) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 3, height: 150)
                .onTapGesture {
                    isDetailActive = true
                }
            
            HStack(spacing: 8) {
                Spacer(minLength: 0)
                Text(item.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
            }
        }
        .padding(.top)
        .padding(.leading)
        .padding([.bottom, .trailing], 5)
        .background(
            item.color.opacity(0.7)
                .clipShape(CustomCorner(corner: [.topLeft, .topRight, .bottomLeft], size: 25))
                .padding(.top, 55)
        )
        .fullScreenCover(isPresented: $isDetailActive) {
            DetailView(selectedItem: item)
        }

    }
}
        
