//
//  LoadingView.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct LoadingView: View {
    let message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            ProgressView()
            if let message = message {
                Text(message)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
            }
        }
    }
} 
