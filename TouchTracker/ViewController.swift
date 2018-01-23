//
//  ViewController.swift
//  TouchTracker
//
//  Created by Gilbert Lo on 1/20/18.
//  Copyright © 2018 Gilbert Lo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view, typically from a nib.
        view = DrawView()
        view.isMultipleTouchEnabled = true
        view.backgroundColor = .white
        
        setupGestureRecognizers(view as! DrawView)
    }
    
    fileprivate func setupGestureRecognizers(_ view: DrawView) {
        let doubleTapRecognizer = UITapGestureRecognizer(target: view, action: #selector(view.handleDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        view.addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: view, action: #selector(view.handleSingleTap))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        view.addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: view, action: #selector(view.handleLongPress))
        view.addGestureRecognizer(longPressRecognizer)
        
        view.moveRecognizer = UIPanGestureRecognizer(target: view, action: #selector(view.handlePan))
        view.moveRecognizer.cancelsTouchesInView = false
        view.moveRecognizer.delegate = view
        view.addGestureRecognizer(view.moveRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

