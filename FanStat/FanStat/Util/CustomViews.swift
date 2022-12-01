
//
//  Created by Krishna Raj S on 4/16/20.
//  Copyright © 2020 AppLab. All rights reserved.
//

import Foundation
import SJFrameSwift
import UIKit
import QuartzCore

//================================================//
//MARK: - CustomLabel
//================================================//
@IBDesignable
class CustomLabelLocal: UILabel {
    var fontStyle:AppFont.FontType = .regular
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setFont()
    }
    
    func refreshUI() {
        setFont()
    }
    
    @IBInspectable public var direction:Bool = false{
        didSet{
            setFont()
        }
    }
    
    @IBInspectable public var inverse:Bool = false{
        didSet{
            setFont()
        }
    }
    
    @IBInspectable public var localKey:String = "" {
        didSet{
            setFont()
        }
    }
    
    @IBInspectable public var fontExtraBold:Bool = false{
        didSet{
            if fontExtraBold {
                fontStyle = .extraBold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontBold:Bool = false{
        didSet{
            if fontBold {
                fontStyle = .bold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontSemiBold:Bool = false{
        didSet{
            if fontSemiBold {
                fontStyle = .semibold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontMedium:Bool = false{
        didSet{
            if fontMedium {
                fontStyle = .medium
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontRegular:Bool = false{
        didSet{
            if fontRegular {
                fontStyle = .regular
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontLight:Bool = false{
        didSet{
            if fontLight {
                fontStyle = .light
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontException:Bool = false{
        didSet{
            if fontException {
                setFont()
            }
        }
    }
    
    func setFont(){
        if fontException {
            self.font = AppFont.getEnglish(type: fontStyle, size: self.font.pointSize)
        }else {
            self.font = AppFont.get(type: fontStyle, size: self.font.pointSize)
        }
        
        if !localKey.isEmpty && Config.renderLable {
            self.text = SJLocalisedString[localKey]
        }
        
        if direction {
            self.textAlignment = AppController.shared.isAppLanguageArabic() ? .right : .left 
        }else if inverse {
            self.textAlignment = AppController.shared.isAppLanguageArabic() ? .left : .right
        }
    }
}

//================================================//
//MARK: - Custom Text Field
//================================================//
@objc protocol CustomTextFieldLocalDelegate {
    @objc optional func didClickedFieldDoneButton(_ textField:CustomTextFieldLocal)
    @objc optional func didClickedFieldNextButton(_ textField:CustomTextFieldLocal)
}

class CustomTextFieldLocal: SJTextField {
    @IBOutlet var customDelegate: CustomTextFieldLocalDelegate?

    var fontStyle:AppFont.FontType = .regular
    var alignment:Bool = false
    var _fontSize:Int = 15

    override func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews {
            if let button = view as? UIButton {
                button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = UIColor(named: "FieldPlaceholder")//.white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setFont()
    }
    
    func refreshUI() {
        setFont()
    }
    
    @IBInspectable public var localKey:String = "" {
        didSet{
            setFont()
        }
    }
    
    @IBInspectable public var fontExtraBold:Bool = false{
        didSet{
            if fontExtraBold {
                fontStyle = .extraBold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontBold:Bool=false{
        didSet{
            if fontBold{
                fontStyle = .bold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontSemiBold:Bool = false{
        didSet{
            if fontSemiBold {
                fontStyle = .semibold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontMedium:Bool=false{
        didSet{
            if fontMedium {
                fontStyle = .medium
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontregular:Bool=false{
        didSet{
            if fontregular{
                fontStyle = .regular
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontLight:Bool=false{
        didSet{
            if fontLight{
                fontStyle = .light
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontException:Bool = false{
        didSet{
            if fontException {
                setFont()
            }
        }
    }
    
    func setFont(){
        if fontException {
            self.font = AppFont.getEnglish(type: fontStyle, size: self.font?.pointSize ?? CGFloat(_fontSize))
        }else {
            self.font = AppFont.get(type: fontStyle, size: self.font?.pointSize ?? CGFloat(_fontSize))
        }
        
        
        if !localKey.isEmpty && Config.renderLable{
            self.placeholder = SJLocalisedString[localKey]
        }
        
        if alignment{
            if AppController.shared.isAppLanguageArabic(){
                self.textAlignment = .right
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.textAlignment = .left
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
        
    }
    
    @IBInspectable public var Alignment:Bool = false{
        didSet{
            alignment = Alignment
            setFont()
        }
    }
    
    @IBInspectable public var doneAccessory:Bool = false {
        didSet{
            if doneAccessory {
//                if AppController.shared.isAppLanguageArabic() {
//                    self.addKeyboardLeftSideToolBarButtons(names: [SJLocalisedString["key_Done"]]) { _ in
//                        self.resignFirstResponder()
//                    }
//                }else {
//                    self.addKeyboardRightSideToolBarButtons(names: [SJLocalisedString["key_Done"]]) { (_) in
//                        self.resignFirstResponder()
//                    }
//                }
                addDoneButton()
            }
        }
    }
    
    @IBInspectable
    public var nextEnabled:Bool =  false {
        didSet{
            addDoneButton()
        }
    }
    
    func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let buttonTitle = nextEnabled ? SJLocalisedString["key_Next"] : SJLocalisedString["key_Done"]
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)


        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        if nextEnabled {
            self.customDelegate?.didClickedFieldNextButton?(self)
        }else {
            self.resignFirstResponder()
            self.customDelegate?.didClickedFieldDoneButton?(self)
        }
    }
    
}

//================================================//
//MARK: - Custom OTP Text Field
//================================================//
/*
@objc protocol VariableFontCustomTextFieldDelegate {
    @objc optional func didClickedFieldDoneButton(_ textField:VariableFontCustomTextField)
    @objc optional func didClickedFieldNextButton(_ textField:VariableFontCustomTextField)
}

@IBDesignable
class VariableFontCustomTextField: UITextField {
    @IBOutlet var customDelegate: VariableFontCustomTextFieldDelegate?
 
    override open func draw(_ rect: CGRect) {
        addDoneButton()
    }
    
    @IBInspectable
    public var nextEnabled:Bool =  false {
        didSet{
            addDoneButton()
        }
    }
    
    @IBInspectable public var Alignment:Bool = false{
        didSet{
            if alignment {
                self.semanticContentAttribute = .forceRightToLeft
            }else {
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    
    func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let buttonTitle = nextEnabled ? SJLocalisedString["key_Next"] : SJLocalisedString["key_Done"]
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)


        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        if nextEnabled {
            self.customDelegate?.didClickedFieldNextButton?(self)
        }else {
            self.resignFirstResponder()
            self.customDelegate?.didClickedFieldDoneButton?(self)
        }
    }
     
}
*/

//================================================//
//MARK: - Custom Text View
//================================================//
protocol CustomTextViewDelegate {
    func didClickedTextViewDoneButton(_ textView:CustomTextView)
}

class CustomTextView: SJTextView {
    var customTextViewDelegate: CustomTextViewDelegate?

    enum fontType {
        case bold
        case semibold
        case regular
        case light
        
    }
    
    var fontStyle:AppFont.FontType = .regular
    var alignment:Bool = false
    var _fontSize:Int = 15
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setFont()
    }
    
    override open func draw(_ rect: CGRect) {
        addDoneButton()
    }
    
    func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: SJLocalisedString["key_Done"] , style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)


        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
        self.customTextViewDelegate?.didClickedTextViewDoneButton(self)
    }
    
    @IBInspectable public var fontExtraBold:Bool = false{
        didSet{
            if fontExtraBold {
                fontStyle = .extraBold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontBold:Bool=false{
        didSet{
            if fontBold {
                fontStyle = .bold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontSemiBold:Bool = false{
        didSet{
            if fontSemiBold {
                fontStyle = .semibold
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontMedium:Bool=false{
        didSet{
            if fontMedium {
                fontStyle = .medium
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontregular:Bool=false{
        didSet{
            if fontregular {
                fontStyle = .regular
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontLight:Bool=false{
        didSet{
            if fontLight {
                fontStyle = .light
                setFont()
            }
        }
    }
    
    @IBInspectable public var fontException:Bool = false{
        didSet{
            if fontException {
                setFont()
            }
        }
    }
    
    func setFont(){
        if fontException {
            self.font = AppFont.getEnglish(type: fontStyle, size: self.font?.pointSize ?? CGFloat(_fontSize))
        }else {
            self.font = AppFont.get(type: fontStyle, size: self.font?.pointSize ?? CGFloat(_fontSize))
        }
        
        
        if alignment{
            if AppController.shared.isAppLanguageArabic(){
                self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
        }
        
    }
    
    public func setText(_ _text:String){
        self.text = _text
        setFont()
    }
    
    @IBInspectable public var voiceText:String = "" {
        didSet{
            self.accessibilityLabel = SJLocalisedString[voiceText]
            self.accessibilityTraits = UIAccessibilityTraits.staticText
        }
    }
}


extension UITextView{
    func setLocalisation(){
        if self is CustomTextView{
            (self as! CustomTextView).setFont()
        }
        
    }
}


class CustomTextViewLocal: CustomTextView {
    @IBInspectable public var Alignment:Bool = false{
        didSet{
            alignment = Alignment
            setFont()
        }
    }
}


//================================================//
//MARK: - Custom Stack View
//================================================//
class CustomStackView: UIStackView {
    @IBInspectable public var SJlocalisation:Bool = false {
        didSet{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}

//================================================//
//MARK: - Custom Switch
//================================================//
class CustomSwitchView: UISwitch {
    @IBInspectable public var SJlocalisation:Bool = false {
        didSet{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}


//================================================//
//MARK: - Custom Collection View
//================================================//
class CustomCollectionView: UICollectionView {
    @IBInspectable public var SJlocalisation:Bool = false {
        didSet{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}

//================================================//
//MARK: - Custom Page Control
//================================================//
class CustomPageController: UIPageControl {
    @IBInspectable public var SJlocalisation:Bool = false {
        didSet{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}

extension SJViewLocal {
    func setLocalisation(){
        if AppController.shared.isAppLanguageArabic(){
            self.semanticContentAttribute = .forceRightToLeft
        }else{
            self.semanticContentAttribute = .forceLeftToRight
        }
    }
}


//================================================//
//MARK: - Custom ImageView Local
//================================================//
class CustomImageViewLocal: UIImageView {
    
    override open func draw(_ rect: CGRect) {
        setLocalisation()
        setCornerRadius()
    }
    
    @IBInspectable public var localization:Bool = false {
        didSet{
            setLocalisation()
        }
    }
    
    func refreshUI() {
        setLocalisation()
        setCornerRadius()
    }

    @IBInspectable public var clipToCircle:Bool = false{
        didSet{
            setCornerRadius()
        }
    }
    
    public func setLocalisation() {
        if localization{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute =  .forceRightToLeft
            }else{
                self.semanticContentAttribute =  .forceLeftToRight
            }
        }
    }
    
    public func setCornerRadius() {
        if clipToCircle {
            DispatchQueue.main.async {
                if(self.frame.size.width > self.frame.size.height){
                    self.layer.cornerRadius = self.frame.size.height/2.0
                }else{
                    self.layer.cornerRadius = self.frame.size.width/2.0
                }
                self.clipsToBounds = true
            }
        }
    }
    
}

//================================================//
//MARK: - Custom ImageView Local
//================================================//
class CustomViewLocal: SJView {
    var textChange: Bool = false {
        didSet {
            backgroundColor = textChange ? UIColor.init(named: "FieldBgGray"): .clear
        }
    }
    override open func draw(_ rect: CGRect) {
        setLocalisation()
        setCornerRadius()
    }
    
    override func layoutSubviews() {
        setCornerRadius()
    }
    
    func refreshUI() {
        setLocalisation()
        setCornerRadius()
    }
    
    
    @IBInspectable public var localization:Bool = false {
        didSet{
            setLocalisation()
        }
    }
    
    public func setLocalisation() {
        if localization{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute =  .forceRightToLeft
            }else{
                self.semanticContentAttribute =  .forceLeftToRight
            }
        }
    }
    
    @IBInspectable public var clipToCircle:Bool = false{
        didSet{
            setCornerRadius()
        }
    }
    
    func setContainerViewBorderColor(error:Bool) {
        if error {
            self.borderColor = UIColor(named: "ErrorRed")!
            self.backgroundColor = UIColor(named: "ErrorLightRedBg")!
        }else {
            self.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
            self.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        }
    }

    
    func setCornerRadius() {
        if clipToCircle {
            if(self.frame.size.width>self.frame.size.height){
                self.layer.cornerRadius = self.frame.size.height/2
            }else{
                self.layer.cornerRadius = self.frame.size.width/2
            }
            self.clipsToBounds = true
        }
    }
}

//MARK: - Gradient Progress View

class GradientProgressBarView: CustomViewLocal {
    
    var isAnimationCompleted = false
    
    var isTransformNeededForArabic: Bool = false {
        
        didSet {
            if isTransformNeededForArabic == true {
                if AppController.shared.isAppLanguageArabic() {
                    self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                }else {
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }else {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    func resetSubLayersForRestartingAnimation() {
        self.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    
    func setProgress(progress: CGFloat, borderColor: UIColor, gradientStart: UIColor, gradientEnd: UIColor) {
        self.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        self.layer.cornerRadius = 3.0
        let width:CGFloat = self.bounds.width
        let height:CGFloat = self.bounds.height
        
        //Bezier Path with cornerRadius at top right and bottom Right
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.bounds.width*progress, height: height), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 3.0, height: 3.0))
        bezierPath.move(to: CGPoint(x: 0, y: height/2.0))
        bezierPath.addLine(to: CGPoint(x: width, y: height/2.0))
        
        //BezierPath without any cornerRadius
        let shapeBezier = UIBezierPath()
        shapeBezier.move(to: CGPoint(x: 0, y: height/2.0))
        shapeBezier.addLine(to: CGPoint(x: width, y: height/2.0))
        
        
        // Shape Layer for the background meroon view for the gap
        let borderLayer = CAShapeLayer()
        borderLayer.path = bezierPath.cgPath
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = height-8
        borderLayer.strokeEnd = progress
        borderLayer.cornerRadius = 3.0
        self.layer.addSublayer(borderLayer)
        
        
        // ShapeLayer which is used to mask the gradient for animation
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapeBezier.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.9701139331, green: 0.5654702187, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = height
        shapeLayer.strokeEnd = progress
        shapeLayer.cornerRadius = 3.0
        self.layer.addSublayer(shapeLayer)
        
        
        let progressWidth = progress*width
        let pointOfTransalation = width*0.75
        let greenLocation = pointOfTransalation/progressWidth
        print("greenLocation: \(greenLocation)")
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width*progress, height: height)
        if progress >= 0.75 {
            gradientLayer.colors = [gradientStart.cgColor, gradientEnd.cgColor]
            gradientLayer.locations = [0.0, NSNumber(floatLiteral: Double(greenLocation))]
        }else {
            gradientLayer.colors = [gradientStart.cgColor, gradientStart.cgColor]
            gradientLayer.locations = [0.0, 1.0]
        }
    
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: progress, y: 0.5)
        gradientLayer.type = .axial
        gradientLayer.mask = shapeLayer
        gradientLayer.cornerRadius = 3.0
       
        self.layer.addSublayer(gradientLayer)

        // Stroke animation for animating shape layer
        let strokeAnim = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeAnim.duration = 1.0
        strokeAnim.fromValue = 0
        strokeAnim.repeatCount = 1
        strokeAnim.toValue = progress
        strokeAnim.isRemovedOnCompletion = false
        strokeAnim.fillMode = .forwards
        
        // Width animation for the back shape layer
        let transformAnim = CABasicAnimation(keyPath: "bounds.size.width")
        transformAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transformAnim.duration = 1.0
        transformAnim.fromValue = (2*self.bounds.width*progress)
        transformAnim.repeatCount = 1
        transformAnim.toValue = 0
        transformAnim.isRemovedOnCompletion = false
        transformAnim.fillMode = .forwards
        
        /*let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.2, 0.0]
        animation.toValue = [0.9, 0.0]
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: nil)*/
        if isAnimationCompleted == false {
            shapeLayer.add(strokeAnim, forKey: "strokeAnim")
            borderLayer.add(transformAnim, forKey: "transformAnim")
        }
    }
}

// MARK: - Dashed View
@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = UIColor.lightGray
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)
            
            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width
            
        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)
            
            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }
        
        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }
    
    private var width : CGFloat {
        return self.bounds.width
    }
    
    private var height : CGFloat {
        return self.bounds.height
    }
}


//================================================//
//MARK: - Custom Scroll Local
//================================================//
class CustomScrollViewLocal: UIScrollView {
    @IBInspectable public var localization:Bool = false {
        didSet{
            setLocalisation()
        }
    }
    
    public func setLocalisation() {
        if localization{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute =  .forceRightToLeft
            }else{
                self.semanticContentAttribute =  .forceLeftToRight
            }
        }
    }
}
 
class CollectionViewLocal: UICollectionView {
    @IBInspectable public var SJlocalisation:Bool = false {
        didSet{
            if AppController.shared.isAppLanguageArabic(){
                self.semanticContentAttribute = .forceRightToLeft
            }else{
                self.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}

class DashedBorder: UIView {
    
    @IBInspectable public var borderColor: UIColor = UIColor.black
    @IBInspectable public var dashPoints: CGFloat = 1
    @IBInspectable public var spacePoints: CGFloat = 1
    @IBInspectable public var cornerRadius: CGFloat = 0
    
    @IBInspectable public var topDash: Bool = true
    @IBInspectable public var bottomDash: Bool = true
    @IBInspectable public var leftDash: Bool = true
    @IBInspectable public var rightDash: Bool = true
    
    private let borderLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadDefaults()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadDefaults()
    }
    
    private func loadDefaults() {
        self.layer.addSublayer(borderLayer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        borderLayer.frame = rect
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = nil
        borderLayer.lineDashPattern = [NSNumber(value: dashPoints), NSNumber(value: spacePoints)]
        
        if topDash && bottomDash && leftDash && rightDash {
            borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        } else {
            
            let topLeft = rect.origin
            let topRight = CGPoint(x: rect.width, y: rect.origin.y)
            let bottomLeft = CGPoint(x: rect.origin.x, y: rect.height)
            let bottomRight = CGPoint(x: rect.width, y: rect.height)
            
        let bezierPath = UIBezierPath()
            
            if topDash {
                bezierPath.move(to: topLeft)
                bezierPath.addLine(to: topRight)
                bezierPath.close()
            }
            
            if rightDash {
                bezierPath.move(to: topRight)
                bezierPath.addLine(to: bottomRight)
                bezierPath.close()
            }
            
            if bottomDash {
                bezierPath.move(to: bottomRight)
                bezierPath.addLine(to: bottomLeft)
                bezierPath.close()
            }
            
            if leftDash {
                bezierPath.move(to: bottomLeft)
                bezierPath.addLine(to: topLeft)
                bezierPath.close()
            }
            
            borderLayer.path = bezierPath.cgPath
        }
    }
}

//================================================//
//MARK: - Custom Scroll Local
//================================================//
@IBDesignable
class CustomViewShadow:UIView {
    
    override open func draw(_ rect: CGRect) {
        //removeShadow()
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
    
    override func layoutSubviews() {
        removeShadow()
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
    
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowOpacity = 0.0
    }
    
    @IBInspectable public var shadowRadius:CGFloat = 0.0 {
        didSet{
            setShadowRadius()
        }
    }
    
    @IBInspectable public var shadowColour:UIColor = UIColor.gray {
        didSet{
            setShadowColour()
        }
    }
    
    @IBInspectable public var shadowOffset:CGSize = CGSize(width: 0, height: 0) {
        didSet{
            setShadowOffset()
        }
    }
    
    @IBInspectable public var shadowOpacity:CGFloat = 0.3 {
        didSet{
            setShadowOpacity()
        }
    }
    
    private func setShadowRadius() {
        self.layer.shadowRadius = shadowRadius
    }
    
    private func setShadowColour() {
        self.layer.shadowColor = shadowColour.cgColor
    }
    
    private func setShadowOffset() {
        self.layer.shadowOffset = shadowOffset
    }
    
    private func setShadowOpacity() {
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
    
}

//========================================================
//MARK: -
//========================================================
@IBDesignable
class CustomViewGradient: CustomViewLocal {
    
    var colourStart:UIColor = UIColor.gray
    var colourEnd:UIColor = UIColor.darkGray
    var startPoint:CGPoint = CGPoint(x: 0, y: 0)
    var endPoint:CGPoint = CGPoint(x: 0, y: 0)
    var layerTopGradient:CAGradientLayer?
    
    override open func draw(_ rect: CGRect) {
        applyGradient()
    }
    
    override func layoutSubviews() {
        applyGradient()
    }
    
    @IBInspectable
    public var ColourStart:UIColor = UIColor.gray{
        didSet{
            colourStart = ColourStart
        }
    }
    
    @IBInspectable
    public var ColourEnd:UIColor = UIColor.darkGray{
        didSet{
            colourEnd = ColourEnd
        }
    }
    
    @IBInspectable
    public var StartPoint:CGPoint = CGPoint(x: 0.5, y: 0){
        didSet{
            startPoint = StartPoint
        }
    }
    
    @IBInspectable
    public var EndPoint:CGPoint = CGPoint(x: 0.5, y: 1){
        didSet{
            endPoint = EndPoint
        }
    }
    
    func applyGradient() {
        if let layerGradient = layerTopGradient {
            layerGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            layerGradient.startPoint = startPoint
            layerGradient.endPoint = endPoint
            layerGradient.colors = [colourStart.cgColor,colourEnd.cgColor]
        }else{
            layerTopGradient = CAGradientLayer()
            layerTopGradient?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            layerTopGradient?.startPoint = startPoint
            layerTopGradient?.endPoint = endPoint
            layerTopGradient?.colors = [colourStart.cgColor,colourEnd.cgColor]
            self.layer.insertSublayer(layerTopGradient!, at: 0)
        }
    }
     
}
