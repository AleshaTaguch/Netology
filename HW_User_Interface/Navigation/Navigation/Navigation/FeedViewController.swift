import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .cyan
        self.title = "Feed"
        
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
        button.setTitle("Go Post View", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func tap() {
        let postViewController = PostViewController()
        postViewController.view.backgroundColor = .red
        postViewController.title = "View Post"
        postViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(postViewController, animated: true)

    }

}
