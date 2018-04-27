
import UIKit

class StartVC: UIViewController {
    //outlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var CreateAccountBtn: UIButton!
   
    @IBAction func loginAsProf(_ sender: Any) {
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! loginVC
        if segue.identifier == "loginAsProfessor"{
           
            destinationVC.loginType = .instructor
        }
        else{
           destinationVC.loginType = .student
        }
    }
    //actions
    @IBAction func loginAsStudent(_ sender: Any) {
    }
    @IBAction func CreateAccountPressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.layer.cornerRadius = 90
        logo.clipsToBounds = true
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.borderWidth = 2.3
        CreateAccountBtn.layer.cornerRadius = 32
        CreateAccountBtn.clipsToBounds = true
  }


}
