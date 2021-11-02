//
//  BaseWindow.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 25/10/21.
//

import UIKit
import Domain

class BaseWindow: UIWindow {

    private var messageView: FeedbackMessageView?
    
    lazy var  presentableMessageTimeCounter: Int = { return 0 }()
    lazy var presentableMessageTimer: Timer = {
        return Timer()
    }()
    
    @objc private func fireTimer() {
        self.presentableMessageTimeCounter += 1
        print("....timer: \(presentableMessageTimeCounter)")
        if self.presentableMessageTimeCounter >= 2 { // present for 2 seconds
            presentableMessageTimer.invalidate()
            self.dismissingFeedbackMessage()
        }
    }
    
    func resetTimer() {
        // set up timer
        print("....RESET TIMER ENTER")
        presentableMessageTimeCounter = 0
        presentableMessageTimer.invalidate()
        
        presentableMessageTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    
    func presentingFeedbackMessage(feedBack: FeedbackMessage) {
        
        // FIXME: - Temp fix for handling presentation of multiple messages
        if messageView != nil {
            dismissingFeedbackMessage {[weak self] in
                self?.resetTimer()
                self?.presentingFeedbackMessage(feedBack: feedBack)
            }
            return
        }
        
        messageView = FeedbackMessageView()
        messageView?.setUpView(message: feedBack)
        
        guard let messageView = messageView else {
            return
        }

        messageView.frame = CGRect(x: 20, y: -80, width: UIScreen.main.bounds.width - 40, height: 80)
        
        self.addSubview(messageView)
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) { [weak self] in
            let topPadding = self?.safeAreaInsets.top ?? 0
            messageView.frame.origin.y = topPadding + 12
        }
        
        animator.addCompletion({[weak self] (_) in
            self?.resetTimer()
        })
        
        animator.startAnimation()
    }
    
    func dismissingFeedbackMessage(completion: (()-> Void)? = nil) {
        guard let messageView = messageView else {
            return
        }
        
        let shrinkAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            messageView.frame.origin.y += 10
            messageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        let dismissAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            messageView.frame.origin.y = -messageView.frame.size.height
        }
        
        shrinkAnimator.addCompletion({ (_) in
            dismissAnimator.startAnimation()
        })
        
        dismissAnimator.addCompletion { [weak self] _ in
            self?.messageView?.removeFromSuperview()
            self?.messageView = nil
            completion?()
        }
        
        shrinkAnimator.startAnimation()
    }
}
