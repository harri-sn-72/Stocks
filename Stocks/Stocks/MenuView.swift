//
//  MenuView.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 6/3/21.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var selectedTab: String
    @Namespace var animation
    var body: some View {
        ZStack {
            Color("Dark")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                Image("logo")
                    .cornerRadius(15)
                    .padding(.top,50)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    TabButtons(image: "dollarsign.square", title: "Market", selectedTab: $selectedTab, animation: animation)
                    TabButtons(image: "building.columns", title: "Business News", selectedTab: $selectedTab, animation: animation)
                    TabButtons(image: "apps.iphone", title: "Tech News", selectedTab: $selectedTab, animation: animation)
                    
                    
                    
                }
                .padding(.leading, -15)
                .padding(.top, 50)
                
                Spacer()
               
                VStack(alignment: .leading, spacing: 6) {
                    
                
                    Text("App Version 1.2.50")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                    
                    Text("Copyright Up + Down.\nHarrinadhaan Sathish Kumaar Nirmala")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
       MainView()
    }
}

struct TabButtons: View {
    var image: String
    var title: String
    
    @Binding var selectedTab: String
    
    var animation: Namespace.ID
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                selectedTab = title
            }
        }) {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("Background") : .white)
            .padding(.horizontal,12)
            .padding(.vertical,10)
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
                ZStack {
                    if selectedTab == title {
                        Color.white.opacity(selectedTab == title ? 1 : 0)
                            .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        }
    }
}

extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
struct MainView: View {
    
    @State var selectedTab = "Home"
    @State var showMenu = false
    
    var body: some View {
        ZStack{
            Color("Dark")
                .ignoresSafeArea()
            
ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
            SideMenuView(selectedTab: $selectedTab)
    
})
            
ZStack{
    
    Color.white.opacity(0.5)
        .cornerRadius(showMenu ? 15 : 0)
        .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
        .offset(x: showMenu ? -25 : 0)
        .padding(.vertical,30)
    Color.white.opacity(0.4)
        .cornerRadius(showMenu ? 15 : 0)
        .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
        .offset(x: showMenu ? -50 : 0)
        .padding(.vertical,60)
    
    MenuHome(selectedTab: $selectedTab)
        .cornerRadius(showMenu ? 15 : 0)
        .disabled(showMenu ? true : false)
    
}

.scaleEffect(showMenu ? 0.84 : 1)
.offset(x: showMenu ? getRect().width - 120 : 0)
.ignoresSafeArea()
.overlay(
Button(action: {
        withAnimation(.spring()){
            showMenu.toggle()
            
        }
    
}, label: {
    VStack(spacing: 5){
        Capsule()
            .fill(showMenu ? Color.white : Color.primary)
            .frame(width: 30, height: 3)
            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
            .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
        VStack(spacing: 5){
            Capsule()
                .fill(showMenu ? Color.white : Color.primary)
                .frame(width: 30, height: 3)
            Capsule() .fill(showMenu ? Color.white : Color.primary)
                .frame(width: 30, height: 3)
                .offset(y: showMenu ? -8 : 0)
            
        }
        .rotationEffect(.init(degrees: showMenu ? 50 : 0))
        
    }
    
})
.padding()
,alignment: .topLeading
)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct MenuHome: View {
    @Binding var selectedTab: String
    
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tag("Market")
                .padding(.top, 35)
            NewsView()
                .tag("Business News")
            TechNewsView()
                .tag("Tech News")
        }
    }
}
