//
//  DetailView.swift
//  Friendr
//
//  Created by Aaron Dupont on 2/7/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Text(user.wrappedName)
                .font(.headline)
            Spacer()
            Text(user.wrappedAbout)
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User())
    }
}
