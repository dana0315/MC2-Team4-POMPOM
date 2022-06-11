//
//  CoupleView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/09.
//

import SwiftUI

struct CoupleView: View {
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("POMPOM")
                        .font(.custom("Montserrat-ExtraBold", size: 20))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Hello world")) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
}

struct CoupleView_Previews: PreviewProvider {
    static var previews: some View {
        CoupleView()
    }
}
