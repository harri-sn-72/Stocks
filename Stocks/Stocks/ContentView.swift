//
//  ContentView.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 6/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stockManager = StockQuoteManager()
    @ObservedObject var newsManager = NewsDownloadManager()
    @ObservedObject var nameManager = SearchManager()
    
    @State private var stocks = UserDefaultsManager.shared.savedSymbols
    @State private var searchTerm = ""
    @State private var newsOpen = false
    @State private var oldStocks = [String]()
    
    @State private var sheet = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    func removeItems(at offset: IndexSet) {
       stocks.remove(atOffsets: offset)
   }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                
                VStack(alignment: .leading) {
                    HeaderView(stocks: $stocks)
                        .padding(.top, 50)
                        .frame(height: newsOpen ? CGFloat(0) : 100)
                        .transition(.move(edge: .top))
                  
                    
                    List {
                                Group {
                            SearchTextView(searchTerm: $searchTerm)
                                    
                                
                            
                            ForEach(getQuotes()) { quote in
                                NavigationLink(destination: DetailQuoteView(quote: quote, nameManager: nameManager)) {
                                    QuoteCell(quote: quote)
                                        
                                }
                                
                            }
                            
                        }.listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        
                    }.onAppear {
                        fetchData(for: stocks)
                        oldStocks = stocks
                    }.onChange(of: stocks, perform: { value in
                        fetchData(for: stocks.difference(from: oldStocks))
                        oldStocks = stocks
                    })
                    .listStyle(PlainListStyle())
                    .foregroundColor(.white)
                    NavigationLink(destination: CryptoView()) {
                        HStack {
                            Image(systemName: "bitcoinsign.square")
                            Text("Crypto")
                            Image(systemName: "chevron.right")
                        }
                        .font(.headline)
                        .navigationBarHidden(true)
                    }

                }.padding(.horizontal, 32)
                .padding(.bottom, UIScreen.main.bounds.height * 0.21)
                
                
            }.edgesIgnoringSafeArea(.all)
        }
    }
   
    
    private func getQuotes() -> [Quote] {
        return searchTerm.isEmpty ? stockManager.quotes : stockManager.quotes.filter { $0.symbol.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private func fetchData(for symbols: [String]) {
        stockManager.download(stocks: symbols) { _ in
            
        }
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
