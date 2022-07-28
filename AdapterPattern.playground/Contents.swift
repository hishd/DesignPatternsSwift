import UIKit
import Foundation

//Mock Response format
/*
 [
    {
        "user":{"id":1,"name":"Hishara","email":"hisharadilshan3@gmail.com","phone":"+94711116601"},
        "id":"1"
    }
 ]
 */

struct UserData: Decodable {
    let user: User
}

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
}

//The API Client which handles the API calls
class ApiClient {
    static let shared = ApiClient()
    private init() {}
    
    func login(callback: @escaping (User) -> Void) {
        guard let url = URL(string: "https://62e2b9533891dd9ba8eebac3.mockapi.io/login") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if (200...300).contains(response.statusCode) {
                    print("Response Success")
                } else {
                    print("Response Error")
                }
                
                guard let data = data else {
                    print("Data not found")
                    return
                }
                
                do {
                    let userData = try JSONDecoder().decode([UserData].self, from: data).first
                    if let userData = userData {
                        callback(userData.user)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                print("Could not cast to HTTPURLResponse")
            }
        }.resume()
    }
}

//Protocol for Components
protocol LoginClient {
    func login(callback: @escaping (User) -> Void)
}

//The Login components which holds a LoginClient abstract type
class LoginComponent {
    private let adapter: LoginClient
    
    init(adapter: LoginClient) {
        self.adapter = adapter
    }
    
    func performLogin(callback: @escaping (User) -> Void) {
        adapter.login(callback: callback)
    }
}

//The Mock Data Adapter Class
class MockLoginClientAdapter: LoginClient {
    func login(callback: @escaping (User) -> Void) {
        callback(User(id: 0, name: "Test User", email: "testemail@domain.com", phone: "0711116687"))
    }
}

//The Real Data Adapter Class
class LoginClientAdapter: LoginClient {
    let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
    
    func login(callback: @escaping (User) -> Void) {
        api.login(callback: callback)
    }
}

let loginComponent = LoginComponent(adapter: LoginClientAdapter(api: ApiClient.shared))

loginComponent.performLogin { user in
    print(user)
}
