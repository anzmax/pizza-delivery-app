//
//  LocalAuthorizationService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 30.04.2024.
//

import LocalAuthentication

class LocalAuthorizationService {
    func authorizeIfPossible(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Для доступа требуется аутентификация") { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
