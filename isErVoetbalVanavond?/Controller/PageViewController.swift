//
//  PageViewController.swift
//  isErVoetbalVanavond?
//
//  Created by Tell van den Bergh on 17/01/2019.
//  Copyright © 2019 Tell van den Bergh. All rights reserved.
//

import UIKit
import Foundation

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl()
    let mainVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            let middle = orderedViewControllers[1]
            self.setViewControllers([middle], direction: .forward, animated: false, completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
        assignbackground()
        
    }
    
    
    
    
    func assignbackground(){
        let background = UIImage(named: "Stadium")
        var imageView : UIImageView
        
        
        
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.image = background
        imageView.center = view.center
        
        if UIScreen.main.bounds.width < 567 {
            imageView.isHidden = true
        } else {
            imageView.isHidden = false
        }
        
    
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
 
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) 
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pageControl.currentPage = 1
        self.view.addSubview(pageControl)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
 
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "1"),
                self.newVC(viewController: "2"),
                self.newVC(viewController: "3")]
    }()

    
    func newVC (viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.assignbackground()
            self.pageControl.pageIndicatorTintColor = UIColor.clear
            self.pageControl.currentPageIndicatorTintColor = UIColor.clear
            
        }
    }

}
