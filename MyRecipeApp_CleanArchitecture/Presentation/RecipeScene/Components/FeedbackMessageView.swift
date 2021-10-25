//
//  FeedbackMessageView.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 25/10/21.
//

import UIKit

@IBDesignable
class FeedbackMessageView: UIView {
    // MARK: - OUTLET
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    
    // MARK: - VARS
    let kCONTENT_XIB_NAME = "FeedbackMessageView"
    private var message: FeedbackMessage?
    
    // MARK: - INITS
    override init(frame: CGRect) { // for using custom view in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) { // for using custom view in xib
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - DISIGNABLE IMPLEMENTATION
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func setUpView(message: FeedbackMessage) {
        self.message = message
        messageLbl.text = message.message
        
        switch message.type {
        case .success:
            contentView.backgroundColor = .systemGreen
        case .error:
            contentView.backgroundColor = .systemRed
        case .info:
            contentView.backgroundColor = .systemBlue
        }
    }
}
