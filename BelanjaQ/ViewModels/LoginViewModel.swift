//
//  LoginViewModel.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import Foundation

public final class LoginViewModel {
    var pref: UserDefaults!
    
    init() {
        pref = UserDefaults.standard
    }
    
    func checkUserExist() -> Bool {
        if let userStr = UserDefaults.standard.object(forKey: "user") as? String {
            if let _ = CodableObject.decodeToObject(type: User.self, data: userStr) {
                return true
            }
        }
        return false
    }
    
    func storeUser(user: User) {
        pref.set(CodableObject.encodeToString(value: user), forKey: "user")
    }
    
    func storeUser(data: NSDictionary) {
        guard let id = data.value(forKey: "id") as? String else { return }
        guard let firstName = data.value(forKey: "first_name") as? String else { return }
        guard let lastName = data.value(forKey: "last_name") as? String else { return }
        guard let email = data.value(forKey: "email") as? String else { return }
        let user = User(id: id, name: "\(firstName) \(lastName)", email: email)
        pref.set(CodableObject.encodeToString(value: user), forKey: "user")
    }
    
    func standardLogin(_ username: String?, pswd: String?, remember: Bool) -> Bool {
        if let username = username {
            if let pswd = pswd {
                if username.trimmingCharacters(in: .whitespaces).count > 0 && pswd.trimmingCharacters(in: .whitespaces).count > 0 {
                    print("checkboxValueChanged \(remember)")
                    if remember {
                        pref.set(username, forKey: "username")
                    } else {
                        pref.removeObject(forKey: "username")
                    }
                    let user = User(id: "0", name: username, email: pswd)
                    storeUser(user: user)
                    return true
                }
            }
        }
        return false
    }
}
