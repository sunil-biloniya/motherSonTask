//
//  TitleText.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//
import SwiftUI

struct TitleText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
} 
