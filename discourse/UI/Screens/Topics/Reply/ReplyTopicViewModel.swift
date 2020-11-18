//
//  ReplyTopicViewModel.swift
//  discourse
//
//  Created by Sonia Sieiro on 17/11/2020.
//

import Foundation
import Resolver

protocol ReplyTopicCoordinatorDelegate {
    func replyDidCreate()
    
    func replyCanceled()
}

protocol ReplyTopicViewDelegate {
    func onInvalidReplyTopicData(_ errors: [FormError])
    
    func onReplyTopicError(_ error: Error?)
}

class ReplyTopicViewModel {
    var coordinatorDelegate: ReplyTopicCoordinatorDelegate?
    var delegate: ReplyTopicViewDelegate?
    @LazyInjected var formValidator: FormValidator
    @LazyInjected var dataClient: DataClient
    
    let topic: TopicItem
    
    init(topic: TopicItem) {
        self.topic = topic
    }
    
    func reply(withData data: ReplyTopicForm) {
        let errors = formValidator.validate(data)
        
        if !errors.isEmpty {
            delegate?.onInvalidReplyTopicData(errors)
            
            return
        }
        
        dataClient.replyTopic(withData: data) {
            self.coordinatorDelegate?.replyDidCreate()
        } onError: { (error) in
            self.delegate?.onReplyTopicError(error)
        }
        
    }
    
    func cancelReply() {
        coordinatorDelegate?.replyCanceled()
    }
    
    
}
