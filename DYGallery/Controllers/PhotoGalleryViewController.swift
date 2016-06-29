//
//  PhotoGalleryViewController.swift
//  Furny
//
//  Created by Adrià Carro on 07/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet var pageControl: UIPageControl!
    
    
    var product: Product!
    private let showPageControl: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        setupPageControl()
    }
    
    
    // MARK: - Config UI
    
    private func configCollectionView() {
        collectionView.registerNib(UINib(nibName: "PhotoCell", bundle:nil), forCellWithReuseIdentifier: "PhotoCell")
        
        collectionView.contentInset = UIEdgeInsetsZero
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero
        collectionView.layoutIfNeeded()
        let indexPath = NSIndexPath(forItem: product.activeImage, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = product.images.count
        pageControl.currentPage = product.activeImage
        pageControl.alpha = 1
        pageControl.hidden = !self.showPageControl
    }
    
}

extension PhotoGalleryViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}

extension PhotoGalleryViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        cell.image = product.images[indexPath.row]
        
        return cell
    }
    
}


extension PhotoGalleryViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPage: Int = Int(scrollView.contentOffset.x/collectionView.frame.size.width)
        pageControl.currentPage = currentPage
        product.activeImage = currentPage
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        pageControl.alpha = 1.0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UIView.animateWithDuration(
            1.0,
            delay: 2.0,
            options: .CurveEaseInOut,
            animations: {
                self.pageControl.alpha = 0.0
            },
            completion: nil
        )
    }
    
}
