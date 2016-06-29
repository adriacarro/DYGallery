//
//  GalleryPresentAnimationController.swift
//  DYGallery
//
//  Created by Adrià Carro on 27/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class GalleryAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRectZero
    var originImage: String!
    var presenting = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        let initialFrame = originFrame
        var finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        let image = UIImage(named: originImage)!
        let newHeight = (finalFrame.width / image.size.width) * image.size.height
        finalFrame.origin.y = (finalFrame.size.height - newHeight) / 2
        finalFrame.size.height = newHeight
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = presenting ? initialFrame : finalFrame
        
        let background = UIView(frame: containerView.frame)
        background.backgroundColor = UIColor.blackColor()
        background.center = containerView.center
        background.alpha = presenting ? 0 : 1
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(background)
        containerView.addSubview(imageView)
        if presenting {
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
                imageView.frame = self.presenting ? finalFrame : initialFrame
                background.alpha = self.presenting ? 1 : 0
            }, completion: { _ in
                if self.presenting {
                    toVC.view.hidden = false
                } else {
                    fromVC.view.hidden = false
                }
                imageView.removeFromSuperview()
                background.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
