import UIKit

extension UIImageView {
    func roundImage(name: UIImageView) {
        name.layer.cornerRadius = name.frame.height/2
    }
}

