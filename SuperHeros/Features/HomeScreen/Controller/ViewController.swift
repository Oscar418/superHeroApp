import UIKit

class ViewController: UIViewController {
    
    var randomNumber = Int()
    @IBOutlet weak var heroQuestionLabel: UILabel!
    
    override func viewDidLoad() {
        heroQuestionLabel.text = NSLocalizedString("heroQuetion", comment: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let superHeroViewController = segue.destination as! SuperHeroViewController
        superHeroViewController.randomNumber = randomNumber
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRandomNumber()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ViewController {
    func getRandomNumber() {
        randomNumber = Int.random(in: 0..<300)
    }
}

