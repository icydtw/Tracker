import UIKit

final class FirstOnboardingPageViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstOnboardPageImage")
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .brown
    }
    
    private func setupProperties() {
        view.addSubview(backgroundImage)
    }
    
}
