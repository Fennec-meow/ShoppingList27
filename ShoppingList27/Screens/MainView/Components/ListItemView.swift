//
//  ListItemView.swift
//  ShoppingList27
//
//  Created by Hajime4life on 07.09.2025.
//

import SwiftUI

struct ListItemView: View {
    
    let item: ListItem
        
    var body: some View {
        HStack(spacing: 0) {
            
            ZStack {
                Circle()
                    .fill(item.circleColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48)
                
                Image(item.circleIcon)
                    .foregroundColor(.grey80)
                    .colorScheme(.light)
            }
            
            Text(item.title)
                .font(.Title3.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
            
            Text("\(item.currentCount)")
                .font(.Body.regular)
            Text("/")
            Text("\(item.totalCount)")
                .font(.Headline.medium)
            
        }
        .padding(.horizontal)
        .padding(.vertical, 18)
        .background(Color.bgcolor)
        .cornerRadius(16)
    }
}

#Preview {
    VStack {
        ListItemView(item: ListItem.mock)
        ListItemView(item: ListItem.mock2)
        ListItemView(item: ListItem.mock3)
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundScreen)
}
