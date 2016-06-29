//
//  SwipeInteractionController.swift
//  DYGallery
//
//  Created by Adrià Carro on 27/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview!)
        var progress = (translation.y / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
                
        switch gestureRecognizer.state {
            
        case .Began:
            interactionInProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            shouldCompleteTransition = progress > 0.5
            updateInteractiveTransition(progress)
            
        case .Cancelled:
            interactionInProgress = false
            cancelInteractiveTransition()
            
        case .Ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
            
        default:
            print("Unsupported")
        }
    }
    
}
