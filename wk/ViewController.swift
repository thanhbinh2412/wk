import UIKit

class ViewController: UIViewController {
    @IBAction func buttonPress(_ sender: Any) {
        print("button Press")
        self.performSegue(withIdentifier: "SecondViewSg", sender: self)
        //self.performSegue(withIdentifier: "HomeScreenSegue2", sender: self)
    }
    
    
    struct defaultKeys {
        static let keyLogin = "loginKey"
    }
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let stringOne = defaults.string(forKey: "loginKey") as? String ?? String()
        
        if stringOne == "login done" {
            print(stringOne)
            performSegue(withIdentifier: "HomeScreenSegue2", sender: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func   viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
 
}
