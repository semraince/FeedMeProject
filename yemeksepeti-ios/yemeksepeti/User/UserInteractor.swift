//
//  UserInteractor.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

import Foundation
import FirebaseAuth
import NetworkAPI

struct LoginResponse: Decodable {
    let id: Int
    let email: String
    let totalBasketPrice: Double
    let activeAddress: ActiveAddress

}

struct ActiveAddress: Decodable {
    let id: Int
    let name, city, district, street: String
    let apartmentNo, floorNo, phoneNumber, userName: String
    let userSurname: String
    let isActive: Bool
}
struct CreateUserResponse: Decodable {
    let id: Int
    let email: String
}

typealias UserLoginResult = APIResponse<LoginResponse>
typealias CreateUserResult = APIResponse<CreateUserResponse>

protocol UserInteractorInterface {
    func createUser(email: String, password: String)
    func loginUser(email: String, password:String)
}

final class UserInteractor {
    //weak var presenter: HomePresenterInterface?
    //var output: HomeInteractorOutput?
}

extension UserInteractor: UserInteractorInterface {
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print(error)
            }
            
            else{
                let userInfo = Auth.auth().currentUser
                let uid = Auth.auth().currentUser?.uid
                
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print(error)
            }
            else {
                let userInfo = Auth.auth().currentUser
                let uid = Auth.auth().currentUser?.uid
                
            }
        }
    }
    
    private func handleWithLogin(uid: String){
        APIClient.shared.request(responseType: CreateUserResponse.self, router: UserEndpointItem.login(userId: uid)) { [weak self] result in
            print(result)
           // self?.output?.handleLoginResult(result)
            
        }
    }
}
