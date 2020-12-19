//
//  DetailViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/11/08.
//


import UIKit
import WebKit
import SDWebImage

class DetailViewController: UIViewController {

    var url = String()
    var name = String()
    var image = String()


    
    @IBOutlet weak var webView: WKWebView!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

  
        print("（１）あいうえおかきくけこさしすせそ[\(url)]")
        
        //リクエスト
        let reqest = URLRequest(url: URL(string: url)!)
        webView.load(reqest)
            
            
        print("（２）あいうえおかきくけこさしすせそ[\(url)]")
    }

    }
    
    
