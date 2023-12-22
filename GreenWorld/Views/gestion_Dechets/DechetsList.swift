//
//  DechetsList.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct DechetsList: View {
    @Binding var presentSideMenu: Bool

    @State var search = ""
    @State var detail = false
 @State var selectedItem: Type?  // Use your actual item type here
    @State var isSmallDevice = UIScreen.main.bounds.height < 850

    var body: some View {
        VStack {
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(spacing: 10) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            TextField("Find something tasty", text: $search)
                        }
                        
                        Divider()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 20) {
                            ForEach(items) { item in
                                ItemView(item: item)
                                    .onTapGesture {
                                        detail = true
                                    }
                            }
                            .fullScreenCover(isPresented: $detail) {
                                           if let selectedItem = selectedItem {
                                               DetailView(selectedItem: selectedItem)
                                           }
                                       }
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
            .fullScreenCover(isPresented: $detail) {
                           if let selectedItem = selectedItem {
                               DetailView(selectedItem: selectedItem)
                           }
                       }
        }
    }}
