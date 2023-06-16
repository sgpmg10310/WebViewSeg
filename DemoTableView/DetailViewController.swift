//
//  DetailViewController.swift
//  DemoTableView
//
//  Created by JONG DEOK KIM on 2022/10/03.
//

import UIKit
import WebKit

class DetailViewController: UIViewController,
WKUIDelegate, WKNavigationDelegate {

    var webView:WKWebView!
    var activityIndicator:UIActivityIndicatorView =
        UIActivityIndicatorView()
    
    @IBOutlet var navItem: UINavigationItem!
    
    var user:ResultsData? = nil
    
    override func loadView() {
        webView = WKWebView(frame: CGRect.zero)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let searchStr = "https://search.naver.com/search.naver?query="
            + (user?.location.street.name)!
        let searchStr2 = searchStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        self.navItem.title = (self.user?.location.street.name)!
        let req = URLRequest(url: URL(string: searchStr2!)!)
        
        self.webView.load(req)
        
                
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator =
               UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
           activityIndicator.frame =
               CGRect(x: view.frame.midX-50, y: view.frame.midY-50,
                      width: 100, height: 100)
           activityIndicator.color = UIColor.red
           activityIndicator.hidesWhenStopped = true
           activityIndicator.startAnimating()
           self.view.addSubview(activityIndicator)

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.removeFromSuperview()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
