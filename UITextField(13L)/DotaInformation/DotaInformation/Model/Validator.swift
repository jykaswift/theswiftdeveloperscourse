//
//  Validator.swift
//  DotaInformation
//
//  Created by Евгений Борисов on 12.10.2023.
//

import Foundation

class Validator {
    static func isValidEmail(email: String?) -> Bool {
        if email == nil { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(password: String?) -> Bool {
        if password == nil { return false }
        return password!.count >= 6
    }
    
    static func isValidUsername(username: String?) -> Bool {
        if username == nil { return false }
        return username!.count >= 4
    }
}
