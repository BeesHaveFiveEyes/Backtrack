//
//  WelcomeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/06/2022.
//

import SwiftUI

struct Greeting {

    struct Item: Identifiable {
        var id: Int
        var icon: String
        var iconColor: Color
        var title: String
        var description: String
    }
    
    var title: String
    var items: [Greeting.Item]
    
    var image: Image?
    
    static let welcomeGreeting = Greeting(
        title: UIDevice.current.userInterfaceIdiom == .pad ? "Welcome to Backtrack for iPad" : "Welcome to\nBacktrack", items: [
            Item(
                id: 0,
                icon: "mountain.2.fill",
                iconColor: .white,
                title: "Plan your Hikes",
                description: "Lorem ipsum dolor sit amet constetum polaris con astrum deus."
            ),
            Item(
                id: 1,
                icon: "backpack.fill",
                iconColor: .white,
                title: "Craft your Kit List",
                description: "Input your items just once, then reuse them across all of your hikes!"
            ),
            Item(
                id: 2,
                icon: "chart.bar.xaxis",
                iconColor: .white,
                title: "View Pack Insights",
                description: "Lorem ipsum dolor sit amet constetum polaris con astrum deus."
            ),
        ],
        image: Image(.hikers5)
        //9
        //6
    )
}

struct GreetingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var greeting: Greeting
    
    var photographic: Bool {
        return greeting.image != nil
    }
    
    var content: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text(greeting.title)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundStyle(photographic ? .white : .primary)
                        .slideInAfter(0.6)
                }
                Spacer()
            }
            .padding(.vertical, 50)
            
            VStack{
                ViewThatFits(in: .vertical) {
                    VStack {
                        ForEach(greeting.items) {
                            GreetingViewDetailView(item: $0, photographic: photographic)
                                .fadeInAfter(offset: $0.id, withDelay: 0.01)
                        }
                    }
                    .appearAfter(1.99)
                    .fixedSize(horizontal: false, vertical: true)
                    ScrollView {
                        ForEach(greeting.items) {
                            GreetingViewDetailView(item: $0, photographic: photographic)
                        }
                    }
                }
            }
            .frame(maxWidth: 500)
            
            Spacer()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if #available(iOS 16.0, *) {
                content
                    .scrollIndicators(.hidden)
            } else {
                content
            }
            
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                HStack {
                    Spacer()
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                }
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
            .fadeInAfter(offset: greeting.items.count, withDelay: 2)
                        
        }
        .background {
            if let image = greeting.image {
                ZStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .overlay {
                            LinearGradient(colors: [Color.black.opacity(0), Color.black.opacity(0.85)], startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.6))
                                .edgesIgnoringSafeArea(.all)
                        }
                    Spacer()
                }
            }
        }
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(greeting: Greeting.welcomeGreeting)
    }
}

struct GreetingViewDetailView: View {
    
    var item: Greeting.Item
    var photographic = false
    
    var body: some View {
        HStack {
            Image(systemName: item.icon)
                .font(.title.weight(.semibold))
                .frame(width: 50, alignment: .center)
                .foregroundColor(photographic ? .white : item.iconColor)
                    .padding(.trailing)
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.body.weight(.bold))
                    .foregroundColor(photographic ? .white : .primary)
                Text(item.description)
                    .foregroundColor(photographic ? .white : .secondary)
            }
            Spacer()
        }
        .padding()
    }
}
