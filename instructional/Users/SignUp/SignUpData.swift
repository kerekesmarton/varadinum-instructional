import Combine
import SwiftUI

class SignUpData: ObservableObject {
    
    @Published private var name: String = ""
    @Published private var email: String = ""
    
    @Published var nameMessage: String = ""
    @Published var emailMessage: String = ""
    @Published var isValid: Bool = false
    
    func didChange(name: String, isEditing: Bool) {
        self.name = name
    }
    
    func didCommit(name: String) {
        self.name = name
    }
    
    func didChange(email: String, isEditing: Bool) {
        self.email = email
    }
    
    func didCommit(email: String) {
        self.email = email
    }
    
    func done() {
        
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
      $name
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
          return input.count >= 3
        }
        .breakpoint()
        .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
      $email
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            return self.isValidEmail(input)
        }
        .breakpoint()
        .eraseToAnyPublisher()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
      Publishers.CombineLatest(isEmailValidPublisher, isNameValidPublisher)
        .map { emailValid, nameIsValid in
          return nameIsValid && emailValid
        }
        .breakpoint()
      .eraseToAnyPublisher()
    }
    
    init() {
        isNameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
              valid ? "" : "User name must at least have 3 characters"
            }
            .assign(to: \.nameMessage, on: self)
            .store(in: &cancellableSet)
        
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
              valid ? "" : "Must be a valid email"
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}

