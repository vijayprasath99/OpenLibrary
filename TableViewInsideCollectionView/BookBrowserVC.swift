//
//  BookBrowserVC.swift
//  TableViewInsideCollectionView
//
//  Created by Pattur Mohankumar, Vijay Prasath on 8/6/17.
//  Copyright © 2017 Pattur Mohankumar, Vijay Prasath. All rights reserved.
//

import UIKit
import WebKit

class BookBrowserVC: UIViewController, WKNavigationDelegate {
    
    var webView : WKWebView!
    var url : String!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.scrollView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlFormatted = URL(string: url)!
        webView.load(URLRequest(url: urlFormatted))
    }

    // Disable zooming in webView
    func viewForZooming(in: UIScrollView) -> UIView? {
        return nil;
    }
}

extension BookBrowserVC : UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
