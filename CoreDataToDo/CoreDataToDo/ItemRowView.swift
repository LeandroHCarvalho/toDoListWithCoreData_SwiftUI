//
//  ItemRowView.swift
//  CoreDataToDo
//
//  Created by Leandro Carvalho on 13/05/23.
//

import SwiftUI

struct ItemRowView: View {
    
    var item: String
    var creatAt: Date = Date()
    var priority: String
    
    var body: some View {
        HStack {
            Text(priority)
                .font(.headline)
            VStack(alignment: .leading) {
                Text(item)
                    .font(.headline)
                Text("\(creatAt)")
                    .font(.custom("Ariel", size: 10))
                    .lineLimit(3)
            }
        }
        
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: "Test", priority: "Urgent")
    }
}
