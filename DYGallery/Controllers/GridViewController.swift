//
//  GridViewController.swift
//  DYGallery
//
//  Created by Adrià Carro on 28/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    private let productAnimatonController = ProductAnimatonController()
    
    
    var products: [Product] = Product.getProducts()
    var indexPath: NSIndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        configCollectionView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.indexPathsForSelectedItems()?.forEach{ collectionView.deselectItemAtIndexPath($0, animated: false) }
    }
    
    
    // MARK: - Config UI
    
    func configCollectionView() {
        collectionView.registerNib(UINib(nibName: "GridCell", bundle:nil), forCellWithReuseIdentifier: "GridCell")
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "product" {
            let vc = segue.destinationViewController as! ProductsViewController
            vc.products = products
            vc.indexPath = indexPath
            vc.product = products[indexPath.row]
        }
    }
    
    @IBAction func unwindToGridViewController(segue: UIStoryboardSegue) {
        let vc = segue.sourceViewController as! ProductsViewController
        if vc.indexPath != indexPath {
            collectionView.deselectItemAtIndexPath(indexPath, animated: false)
            indexPath = vc.indexPath
            collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
}

extension GridViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.size.width - collectionViewFlowLayout.minimumInteritemSpacing - collectionViewFlowLayout.sectionInset.left - collectionViewFlowLayout.sectionInset.right) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}

extension GridViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GridCell", forIndexPath: indexPath) as! GridCell
        cell.image = products[indexPath.row].image
        return cell
    }
    
}

extension GridViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.indexPath = indexPath
        performSegueWithIdentifier("product", sender: self)
    }
}

extension GridViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        productAnimatonController.push = operation == UINavigationControllerOperation.Push
        if let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath) {
            productAnimatonController.originFrame = collectionView.convertRect(attributes.frame, toView: view)
            productAnimatonController.originFrame.origin.y += productAnimatonController.push ? 0 : Constants.topInsetFix // fix for pull
        }
        productAnimatonController.originImage = products[indexPath.row].image
        return productAnimatonController
    }
}
