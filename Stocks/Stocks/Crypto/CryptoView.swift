//
//  CryptoView.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/7/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CryptoView: View {
    @State var coins: [CryptoData] = []
    var body: some View {
        List(coins) { coin in
            HStack {
                WebImage(url: URL(string: coin.logoURL), options: .highPriority, context: nil)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                    
            Text(coin.name)
                Text(coin.price)
                
            }
        }
            .onAppear {
                Api().getPosts { (coins) in
                    self.coins = coins
                }
            }
    }
}

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}
