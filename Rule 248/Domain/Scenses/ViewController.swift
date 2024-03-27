//
//  ViewController.swift
//  Rule 248
//
//  Created by Bryce Chan on 6/11/2023.
//

import UIKit

protocol PresentStartPageDelegate: AnyObject {
    func presentStartPage()
}

final class ViewController: UIViewController {
    
    // Container view of the segmented control
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Constants.backgroundGreen
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    // Customised segmented control
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()

        // Background and tint colors
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear
        
        // Use a clear image for the background and the dividers
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // Append segments
        segmentedControl.insertSegment(withTitle: "INSTRUCTION", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "GUESSES", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "RESULT", at: 2, animated: true)

        // Select first segment by default
        segmentedControl.selectedSegmentIndex = 0

        // Setup segment text attributes
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ], for: .normal)

        // Set up event handler to get notified when the selected segment changes
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        // Return false because we will set the constraints with Auto Layout
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = Constants.underlineViewColor
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    private let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private var pageViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupPageController()
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubviews(segmentedControl,bottomUnderlineView)
        
        NSLayoutConstraint.activate([
            // Constrain the container view to the view controller
            segmentedControlContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight),
            
            // Constrain the segmented control to the container view
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlContainerView.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedControlContainerView.bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            // Constrain the underline view relative to the segmented control
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)),
            leadingDistanceConstraint
        ])
    }
    
    private func setupPageController() {
        let instructionPageViewController = InstructionPageConfigurator.createScene()
        let guessPageViewController = GuessPageConfigurator.createScene()
        let resultPageViewController = ResultPageViewController()
        
        instructionPageViewController.delegate = self
        
        pageViewControllers.append(contentsOf: [instructionPageViewController, guessPageViewController, resultPageViewController])
        
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.backgroundColor = .white
        pageController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        addChild(pageController)
        view.addSubview(pageController.view)
        
        pageController.didMove(toParent: self)
        pageController.setViewControllers([pageViewControllers[0]], direction: .forward, animated: true)
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: segmentedControlContainerView.bottomAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
        
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if let currentPage = pageController.viewControllers?.first {
            if let currentPageIndex = pageViewControllers.firstIndex(of: currentPage) {
                // for controlling the pageController animate direction
                let segmentedControlIndex = segmentedControl.selectedSegmentIndex
                let direction = currentPageIndex < segmentedControlIndex ?
                UIPageViewController.NavigationDirection.forward  :
                UIPageViewController.NavigationDirection.reverse
                
                pageController.setViewControllers([pageViewControllers[segmentedControl.selectedSegmentIndex]], direction: direction, animated: true)
                changeSegmentedControlLinePosition()
            }
        }
    }

    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
    
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource, PresentStartPageDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) {
            if viewControllerIndex != 0 {
                // go to previous page
                return pageViewControllers[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) {
            if viewControllerIndex < pageViewControllers.count - 1 {
                // go to next page
                return pageViewControllers[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // set the segmentedControl to the index of the current viewController
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pageViewControllers.firstIndex(of: viewControllers[0]) {
                segmentedControl.selectedSegmentIndex = viewControllerIndex
                segmentedControl.sendActions(for: .valueChanged)
            }
        }
    }
    
    func presentStartPage() {
        pageController.setViewControllers([pageViewControllers[1]], direction: .forward, animated: true)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.sendActions(for: .valueChanged)
    }
    
}

