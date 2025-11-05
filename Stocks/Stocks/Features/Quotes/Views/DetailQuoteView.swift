//
//  DetailQuoteView.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 6/2/21.
//

import SwiftUI

struct DetailQuoteView: View {
    var quote: Quote
    @ObservedObject var nameManager: SearchManager
   
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text(quote.symbol)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack {
                        Text(quote.price)
                            .font(.title)
                            .fontWeight(.semibold)
                            
                        Image(systemName: Double(quote.change)! > 0.0 ? "chevron.up.square.fill" : "chevron.down.square.fill")
                    }
                    .foregroundColor(Double(quote.change)! > 0.0 ? Color.green : Color.red)
                    Text(Double(quote.change)! > 0.0 ? "Looks like \(quote.symbol) is skyrocketing!" : "It's okay, you can try again next time \(quote.symbol)...")
                        .foregroundColor(Double(quote.change)! > 0.0 ? Color.green : Color.red)
                }
                .padding(.horizontal)
                Spacer()
               
            }
            Text("Open: ")
                .font(.headline)
                +
                Text(" \(quote.open)")
                .font(.headline)
                .foregroundColor(Double(quote.change)! > 0.0 ? Color.green : Color.red)
                
            Spacer()
            
        }
    }
}

struct DetailQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
