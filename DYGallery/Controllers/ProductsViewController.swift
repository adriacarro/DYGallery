//
//  ProductsViewController.swift
//  DYGallery
//
//  Created by Adrià Carro on 28/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    private let galleryAnimationController = GalleryAnimationController()
    private let swipeInteractionController = SwipeInteractionController()
    
    
    var products: [Product] = Product.getProducts()
    var indexPath: NSIndexPath!
    var product: Product!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems() {
            collectionView.reloadItemsAtIndexPaths(selectedIndexPaths)
        }
    }
    
    
    // MARK: - Config UI
    
    func configCollectionView() {
        collectionView.registerNib(UINib(nibName: "ProductCell", bundle:nil), forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.layoutIfNeeded()
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gallery" {
            let vc = segue.destinationViewController as! PhotoGalleryViewController
            vc.product = products[indexPath.row]
            vc.transitioningDelegate = self
            swipeInteractionController.wireToViewController(vc)
        }
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "gallery" {
        }
    }

}

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height - Constants.topInsetFix)
        return size
    }
    
}

extension ProductsViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        cell.product = products[indexPath.row]
        return cell
    }
    
}

extension ProductsViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        performSegueWithIdentifier("gallery", sender: self)
    }
}

extension ProductsViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentIndex: Int = Int(scrollView.contentOffset.x/collectionView.frame.size.width)
        product = products[currentIndex]
        indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
    }
    
}

extension ProductsViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        galleryAnimationController.originFrame = CGRectMake(0, Constants.topInsetFix, collectionView.frame.size.width, cell.frame.height*2/3)
        galleryAnimationController.originImage = products[indexPath.row].image
        galleryAnimationController.presenting = true
        return galleryAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        galleryAnimationController.originFrame = CGRectMake(0, Constants.topInsetFix, collectionView.frame.size.width, cell.frame.height*2/3)
        galleryAnimationController.originImage = products[indexPath.row].image
        galleryAnimationController.presenting = false
        return galleryAnimationController
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
    
}
