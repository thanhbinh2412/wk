import UIKit

class HomeViewController: UIViewController {
  
    @IBOutlet weak var imageView: UIView!
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        print("dit me m")
    }
    
    @IBOutlet var viewBig: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.viewBig.addGestureRecognizer(gesture)
      
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        performSegue(withIdentifier: "ErrorSegue", sender: nil)
    }
    @objc func imageTapped(sender:UITapGestureRecognizer){
        if sender.state == .ended{
            print("dit me may")
        }
        
    }
    override func   viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
 
}
