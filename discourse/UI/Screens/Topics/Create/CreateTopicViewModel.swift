//
//  CreateTopicViewModel.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 15/11/2020.
//

import Foundation
import Resolver

protocol CreateTopicCoordinatorDelegate {
    func topicDidCreate()
    
    func topicCreationCanceled()
}

protocol CreateTopicViewDelegate {
    func onInvalidCreateTopicData(_ errors: [FormError])
    
    func onCreateTopicError(_ error: Error?)
}

class CreateTopicViewModel {
    var coordinatorDelegate: CreateTopicCoordinatorDelegate?
    var delegate: CreateTopicViewDelegate?
    @LazyInjected var formValidator: FormValidator
    @LazyInjected var dataClient: DataClient
    
    func create(withData data: CreateTopicForm) {
        let errors = formValidator.validate(data)
        
        if !errors.isEmpty {
            delegate?.onInvalidCreateTopicData(errors)
            
            return
        }
        
        dataClient.createTopic(withData: data) {
            self.coordinatorDelegate?.topicDidCreate()
        } onError: { (error) in
            self.delegate?.onCreateTopicError(error)
        }
    }
    
    func cancelCreate() {
        coordinatorDelegate?.topicCreationCanceled()
    }
}
