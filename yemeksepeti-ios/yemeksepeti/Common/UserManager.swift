//
//  UserManager.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation

final class UserManager {
    private var id: Int?
    static let shared = UserManager()
    
    
     func loadUserId(_ userId: Int){
        id = userId;
    }
    
    func getUserId() -> Int?{
        return id;
    }
}
