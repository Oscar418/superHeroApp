import UIKit
import Alamofire
import SDWebImage

class SuperHeroViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroFullNameLabel: UILabel!
    @IBOutlet weak var firstApperanceLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var alterEgoLabel: UILabel!
    var randomNumber = Int()
    var heroName = String()
    var heroImageUrl = String()
    var heroFullName = String()
    var firstAppearance = String()
    var placeOfBirth = String()
    var alterEgo = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        getSuperHeroInfo()
        getSuperHeroImage()
    }
}

extension SuperHeroViewController {
    func setImage() {
        setImage(imageViewName: heroImageView)
    }
    
    func setHeroInfo() {
        heroNameLabel.text = heroName
        heroFullNameLabel.text = heroFullName
        firstApperanceLabel.text = firstAppearance
        placeOfBirthLabel.text = placeOfBirth
        alterEgoLabel.text = alterEgo
    }
    
    func setImage(imageViewName: UIImageView) {
        let downloadUrl = URL(string: heroImageUrl)
        heroImageView.sd_setImage(with: downloadUrl , placeholderImage: nil)
    }
}

extension SuperHeroViewController {
    @IBAction func navigateToPowers(_ sender: Any) {
        let superHeroPowersViewController = Storyboard.superHeroPowers.instantiateViewController(withIdentifier: "superHeroPowersViewController") as! SuperHeroPowersViewController
        superHeroPowersViewController.heroID = randomNumber
        self.navigationController?.pushViewController(superHeroPowersViewController, animated: true)
    }
}

extension SuperHeroViewController {
    func getSuperHeroImage() {
        NetworkAdapter.request(target: .superHeroImage(id: randomNumber), success: { (response) in
            do {
                let data: NSDictionary = try response.mapJSON() as! NSDictionary
                self.heroImageUrl = data["url"] as? String ?? ""
                self.setImage()
            } catch {
                print(error)
            }
        }, error: { (error) in
            print(error)
        }, failure: { (error) in
            print(error)
        })
    }
    
    func getSuperHeroInfo() {
        NetworkAdapter.request(target: .superHeroInfo(id: randomNumber), success: { (response) in
            do {
                let data: NSDictionary = try response.mapJSON() as! NSDictionary
                self.heroName = data["name"] as? String ?? ""
                self.heroFullName = data["full-name"] as? String ?? ""
                self.firstAppearance = data["first-appearance"] as? String ?? ""
                self.placeOfBirth = data["place-of-birth"] as? String ?? ""
                self.alterEgo = data["alter-egos"] as? String ?? ""
                self.setHeroInfo()
            } catch {
                print(error)
            }
        }, error: { (error) in
            print(error)
        }, failure: { (error) in
            print(error)
        })
    }
}
