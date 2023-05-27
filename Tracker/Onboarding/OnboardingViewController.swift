import UIKit

/// Класс, отвечающий за онбординг
final class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Свойства
    lazy var pages: [UIViewController] = {
        let firstPage = OnboardingPageViewController()
        firstPage.backgroundImage.image = UIImage(named: "FirstOnboardPageImage")
        let secondPage = OnboardingPageViewController()
        secondPage.backgroundImage.image = UIImage(named: "SecondOnboardPageImage")
        return [firstPage, secondPage]
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .black
        control.pageIndicatorTintColor = UIColor(red: 0.102, green: 0.106, blue: 0.133, alpha: 0.3)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Отслеживайте только то, что хотите"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 60),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -160)
        ])
    }
    
    /// Настройка свойств
    private func setupProperties() {
        dataSource = self
        delegate = self
        view.addSubview(pageControl)
        view.addSubview(button)
        view.addSubview(label)
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }
    
    /// Метод, срабатывающий после нажатия на button
    @objc
    private func buttonTapped() {
        let tabBar = MainTabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.modalTransitionStyle = .crossDissolve
        vibrate()
        present(tabBar, animated: true)
    }
    
    /// Анимированное изменение текста label
    func animateTextChange(for label: UILabel, newText: String) {
        UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
            label.text = newText
        }, completion: nil)
    }

    /// Метод, нужный для включения вибрации
    private func vibrate() {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    /// Метод для получения предыдущего представления UIPageViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        return pages[previousIndex]
    }
    
    /// Метод для получения следующего представления UIPageViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        return pages[nextIndex]
    }
    
    /// Метод, вызываемый после переключения между контроллерами в UIPageViewController
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
            if currentIndex == 1 {
                animateTextChange(for: label, newText: "Даже если это не литры воды и йога")
            } else {
                animateTextChange(for: label, newText: "Отслеживайте только то, что хотите")
            }
        }
    }
    
}
