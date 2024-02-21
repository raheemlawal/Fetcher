//
//  ContentView.swift
//  Fetcher
//
//  Created by Raheem Lawal on 2/20/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var userFirstName: String = ""
    @State private var fetchTitle: String = ""
    @State private var fetchURL: String = ""
    @State private var userIdInput: String = ""
    
    struct User: Decodable {
        let id: Int8
        let created_at: String
        let first_name: String
        let favorite_color: String
    }
    
    func submitQuery() {
        print("hello")
        Task {
            do {
                let user = try await fetchUserFirstNameFromAPI(userid: userIdInput)

                userFirstName = user.first_name
                fetchTitle = "Fetched from API."
                fetchURL = "Visit https://fastapi-production-3b37.up.railway.app/"
                
                
            } catch {
                print(error)
            }
        }
    }
    
    func fetchUserFirstNameFromAPI(userid: String) async throws -> User {
        let url = URL(string: "https://dummyapi-production-b5d9.up.railway.app/user/\(userid)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(User.self, from: data)

        return decoded
    }

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            
            Text("Fetcher App")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 60))
                .padding(.bottom)
            
            Text("Return first name of a specific user from database.")
                .fontWeight(.light)
                .font(.system(size: 30))
                .padding(.bottom)
            
            TextField("Enter User ID", text: $userIdInput)
                .frame(maxWidth: 200, minHeight: 70)
                .multilineTextAlignment(.center)
                .border(.white)
            
            Button(action: submitQuery, label: {
                            Text("Submit")
                                .fontWeight(.heavy)
                                .font(.system(size: 25))
                        })
                        .frame(minWidth: 300, minHeight: 70)
                        .background(.red)
                        .cornerRadius(10)
                        .padding()
            
            Text("\(userFirstName)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 60))
                .padding(.bottom)
            
            Text("\(fetchTitle)")
                .font(.system(size: 20))
                .padding(.bottom)
            
            Text("\(fetchURL)")
                .font(.system(size: 20))

        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
