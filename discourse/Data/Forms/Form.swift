//
//  FormErrors.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 09/11/2020.
//

import Foundation
import Resolver

protocol Form {
    var fields: [FormField] { get }
}

struct FormField {
    var name: String
    var value: String?
    var constraints: [Constraint] = []
}

struct FormError: Error {
    var field: String
    var message: String
}

enum ConstraintViolation: Error {
    case violation(message: String)
}

class FormValidator {

    func validate(_ form: Form) -> [FormError] {
        var errors: [FormError] = []
        
        form.fields.forEach { field in
            let error = validateField(field.name, value: field.value, constraints: field.constraints)
            
            if nil != error {
                errors.append(error!)
            }
        }
        
        return errors
    }
    
    private func validateField(_ field: String, value: String?, constraints: [Constraint]) -> FormError? {
        do {
            try constraints.forEach { (constraint) in
                try constraint.validate(value)
            }
        } catch ConstraintViolation.violation(let message){
            return FormError(field: field, message: message)
        } catch {
            fatalError()
        }
        
        return nil
    }
}


//MARK: - Constraints

class Constraint {
    static var isRequired = RequiredConstraint()
    static var isEmail = EmailConstraint()
    static func isEqualsTo(_ expectedValue: String?, message: String) -> EqualsContraint {
        return EqualsContraint(expectedValue: expectedValue, message: message)
    }
    
    static func isGreaterThan(_ minValue: Int) -> GreaterThanConstraint {
        return GreaterThanConstraint(minValue: minValue)
    }
    
    func validate(_ value: String?) throws {}
}

class RequiredConstraint: Constraint {
    override func validate(_ value: String?) throws {
        if nil == value || "" == value {
            throw ConstraintViolation.violation(message: NSLocalizedString("validation.required", comment: ""))
        }
    }
}

class EmailConstraint: Constraint {
    override func validate(_ value: String?) throws {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if !emailPred.evaluate(with: value) {
            throw ConstraintViolation.violation(message: NSLocalizedString("validation.email", comment: ""))
        }
    }
}

class EqualsContraint: Constraint {
    var expectedValue: String?
    
    var message: String
    
    init(expectedValue: String?, message: String) {
        self.expectedValue = expectedValue
        self.message = message
    }
    
    override func validate(_ value: String?) throws {
        if expectedValue != value {
            throw ConstraintViolation.violation(message: NSLocalizedString(message, comment: ""))
        }
    }
}

class GreaterThanConstraint: Constraint {
    let minValue: Int
    
    init(minValue: Int) {
        self.minValue = minValue
    }
    
    override func validate(_ value: String?) throws {
        if value != nil && minValue >= value!.count {
            throw ConstraintViolation.violation(message: NSLocalizedString("validation.greater_than", comment: "").replacingOccurrences(of: "{number}", with: String(minValue)))
        }
    }
}
