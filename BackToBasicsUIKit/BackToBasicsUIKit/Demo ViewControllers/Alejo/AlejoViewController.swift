/*
 - UILabel
    - How do you customize: text, font, text color, background color and attributed text
    - How do you make the label support Dynamic Type?
 - UIImageView
    - How do you set an image.
    - How do make the image conserve an aspect ratio.
    - How do you tint the image color (Same icon with different colors)
 */

import UIKit

class AlejoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - UIImageView

        // Provide the image to show in 2 ways
        let image = #imageLiteral(resourceName: "swiftBird")  // Image Literal
//        let image = UIImage(named: "swiftBird")

        // How to tint the image
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .purple

        // How to scale the images based on the bounds of the view.
        imageView.contentMode = .scaleAspectFit

        // MARK: - UILabel
        // MARK: Label with Custom Font
        label1.text = "Label with Custom Dynamic Font"
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label1.backgroundColor = UIColor.darkGray
        let customFont = UIFont(name: "Times New Roman", size: 20)!
        label1.font = UIFontMetrics.default.scaledFont(for: customFont)
        label1.adjustsFontForContentSizeCategory = true
        label1.numberOfLines = 0

        // MARK: Label with System Font
        label2.text = "Label with System Dynamic Font"
        label2.textAlignment = .right
        label2.font = UIFont.preferredFont(forTextStyle: .title2)
        label2.adjustsFontForContentSizeCategory = true
        label2.numberOfLines = 0

        // MARK: Label with Attributed Text
        typealias TextAttributes = [NSAttributedString.Key : Any]
        let underline: TextAttributes = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedText = NSMutableAttributedString(string: "Underscore\n",
                                                      attributes: underline)

        let strikeThrough: TextAttributes = [.strikethroughStyle: 1]
        let strikeThroughText = NSAttributedString(string: "Strikethrough\n",
                                                   attributes: strikeThrough)

        let link: TextAttributes = [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                    .foregroundColor: UIColor.blue]
        let linkText = NSAttributedString(string: "This looks like a link",
                                                   attributes: link)

        attributedText.append(strikeThroughText)
        attributedText.append(linkText)

        label3.attributedText = attributedText
        label3.numberOfLines = 0
    }
}
