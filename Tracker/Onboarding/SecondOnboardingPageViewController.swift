import UIKit

final class SecondOnboardingPageViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SecondOnboardPageImage")
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
