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
        
        setupGestureRecognizers()
    }
    
    fileprivate func setupGestureRecognizers() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        view.addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        view.addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        view.addGestureRecognizer(longPressRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Gestures handlers

    @objc func doubleTap() {
        print("Double tap")
        
        let drawView = view as! DrawView
        drawView.handleDoubleTap()
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer) {
        print("tap")
        
        let drawView = view as! DrawView
        let point = gestureRecognizer.location(in: drawView)
        drawView.handleSingleTap(at: point)
    }
    
    @objc func longPress(_ gestureRecognizer: UIGestureRecognizer) {
        print("long press")
        
        let drawView = view as! DrawView
        let state = gestureRecognizer.state
        let location = gestureRecognizer.location(in: drawView)
        drawView.handleLongPress(for: state, at: location)
    }
}

