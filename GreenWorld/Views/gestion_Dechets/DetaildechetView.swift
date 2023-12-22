//
//  DetaildechetView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct DetaildechetView: View {
       var type: String
        var date: Date
        var heure: Date
        var poids: String
        var adresse: String

        var body: some View {
            VStack {
                Text("Type: \(type)")
                Text("Date: \(date)") //DateFormatter.shortDate)")
                Text("Heure: \(heure)") //DateFormatter.shortTime)")
                Text("Poids: \(poids)")
                Text("Adresse: \(adresse)")
            }
            .padding()
            .navigationBarTitle("Détails")
        }
    }

    struct DetaildechetView_Previews: PreviewProvider {
        static var previews: some View {
            let exampleDate = Date() // Replace with your desired date
            return DetaildechetView(type: "Example Type", date: exampleDate, heure: exampleDate, poids: "Example Weight", adresse: "Example Address")
        }
    }
