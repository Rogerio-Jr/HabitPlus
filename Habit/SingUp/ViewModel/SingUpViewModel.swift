//
//  SingUpViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import SwiftUI
import Combine

class SingUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    @Published var uiState: SingUpUIState = .nome
    
    private let interactor: SignUpInteractor
    
    init (interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    func singUp(){
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFomatted = formatter.date(from: birthday)
        
        guard let dateFomatted = dateFomatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFomatted)
        
        
        let signUpRequest = SingUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthday,
                                          gender: gender.index)
        
       cancellableSignUp = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
                
            } receiveValue: { created in
                if(created) {
                    
                    self.cancellableSignIn = self.interactor.login(signInRequest: SingInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { successSignIn in
                            
                            print(created)
                            self.publisher.send(created)
                            self.uiState = .sucess
                        }
                    
                    
                }
            }
        
        
        //        interactor.postUser(signupRequest: signUpRequest) { (sucessResponse, errorResponse) in
        //            if let error = errorResponse {
        //                DispatchQueue.main.async {
        //                    self.uiState = .error(error.detail)
        //                }
        //            }
        
        //            if let sucess = sucessResponse {
        //
        ////                WebService.login(request: SingInRequest(email: self.email,
        ////                                                        password: self.password)) { (successResponse, errorResponse) in
        ////
        ////                    if let errorSignIn = errorResponse {
        ////                        DispatchQueue.main.async {
        ////                            // Main Thread
        ////                            self.uiState = .error(errorSignIn.detail.message)
        ////                        }
        ////                    }
        ////
        ////                    if let successSignIn = successResponse {
        ////                        DispatchQueue.main.async {
        ////                            print(successSignIn)
        ////                            self.publisher.send(sucess)
        ////                                self.uiState = .sucess
        ////
        ////                        }
        ////                    }
        ////
        ////                }
        //
        //                DispatchQueue.main.async {
        //
        //                }
        //            }
                }
            }
        
        
        extension SingUpViewModel {
            func homeView()-> some View{
                return SingUpViewRouter.makeHomeView()
            }
        }
