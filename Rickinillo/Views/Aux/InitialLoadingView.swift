//
//  InitialLoadingView.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

/// Initial view while we are loading all data
struct InitialLoadingView: View {
    var body: some View {
        VStack {
            Image("rickinillo", bundle: .main)
            HStack {
                Text("Rickinillo is loading... ")
                ProgressView()
            }
        }
    }
}

struct InitialLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        InitialLoadingView()
    }
}
