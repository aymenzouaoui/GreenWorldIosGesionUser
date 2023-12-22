//
//  MainTabbedView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 27/11/2023.
//

import SwiftUI

struct MainTabbedView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                favorite(presentSideMenu: $presentSideMenu)
                    .tag(1)
                DechetsList(presentSideMenu: $presentSideMenu)
                    .tag(3)
                Event(presentSideMenu: $presentSideMenu)
                    .tag(4)
                Product(presentSideMenu: $presentSideMenu)
                    .tag(2)
                //GestionUserProfil(presentSideMenu: $presentSideMenu)
                    .tag(6)
            }
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}
