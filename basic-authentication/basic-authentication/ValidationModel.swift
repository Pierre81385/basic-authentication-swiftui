//
//  AuthenticationModel.swift
//  basic-authentication
//
//  Created by m1_air on 6/11/24.
//

import SwiftUI
import Observation

@Observable class TextFieldValidator {
    var name: String = ""
    var surName: String = ""
    var emailAddress: String = ""
    var password: String = ""
    var passwordVerification: String = ""
    var message: String = ""
    
    func checkText() -> Bool {
        
        if(name.count <= 0) {
            message = "This field cannot be empty."
            return false
        }
        
        return true
    }
    
    func checkEmail() -> Bool {
        
        if(emailAddress.count > 100) {
            message = "Email address is too long."
            return false
        }
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if(emailPredicate.evaluate(with: emailAddress)) {
            return true
        } else {
            message = "A valid email address is required."
            return false
        }
    }
    
    func checkPassword() -> Bool {
        
        if(password.count < 8) {
            message = "Password must be at least 8 characters long."
            return false
        }
        
        if(password.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) == nil) {
            message = "Password must contain at least 1 number."
            return false
        }
        if(password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|:\"';<>,.?/~`")) == nil) {
            message = "Password must contain at least 1 special character."
            return false
        }
        
        if(password != passwordVerification) {
            message = "Passwords must match!"
            return false
        }
        
        return true
        
    }
}

struct AuthenticationModel: View {
    @State var validator = TextFieldValidator()
    @State var valid: Bool = true
    
    var body: some View {
        VStack{
            TextField("email address", text: $validator.emailAddress).onSubmit {
                valid = validator.checkEmail()
            }
            Text(validator.message).foregroundStyle(.red)
        }.padding()
        
    }
}

#Preview {
    AuthenticationModel()
}
