//
//  SubtitleText.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//
import SwiftUI

struct SubtitleText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.secondary)
    }
} 
