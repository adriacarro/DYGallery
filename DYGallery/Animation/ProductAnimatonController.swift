//
//  Animator.swift
//  DYGallery
//
//  Created by Adrià Carro on 28/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class ProductAnimatonController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRectZero
    var originImage: String!
    var push: Bool = true
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        let initialFrame = originFrame
        var finalFrame = transitionContext.finalFrameForViewController(toVC)
        finalFrame.origin.y = Constants.topInsetFix
        finalFrame.size.height = (finalFrame.size.height-Constants.topInsetFix)*2/3
        
        let imageView = UIImageView(image: UIImage(named: originImage))
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = push ? initialFrame : finalFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(imageView)
        
        if push {
            toVC.view.hidden = true
        } else {
            fromVC.view.hidden = true
        }
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(
            duration,
            delay: 0,
            options: .CurveEaseInOut,
            animations: {
                imageView.frame = self.push ? finalFrame : initialFrame
            }, completion: { _ in
                if self.push {
                    toVC.view.hidden = false
                } else {
                    fromVC.view.hidden = false
                }
                imageView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
}
