//
//  CowryInputField.swift
//  cowry-cal
//
//  Created by Bash on 13/07/2023.
//

//import UIKit
//import SnapKit
//import IQKeyboardManagerSwift
//
//class CowryInputField: UIView, UITextFieldDelegate {
//    var didEndEditing:(()->())?
//    var textDidChange: ((String)->())? = nil
//    var textChanged: ((String)->())?
//
//    private var contentMaxLenght = Int.max
//    
//    @IBInspectable var title: String? {
//        set(value){titleLabel.text = value}
//        get{return titleLabel.text}
//    }
//    
//    @IBInspectable var placeholder: String?{
//        set(value){
//            contentTextField.toolbarPlaceholder = value
//            contentTextField.placeholder = value
//        }
//        get{return contentTextField.toolbarPlaceholder ?? contentTextField.placeholder}
//    }
//    
//    @IBInspectable var content: String?{
//        set(value){contentTextField.text = value}
//        get{return contentTextField.text}
//    }
//    
//    @IBInspectable var leftIcon:UIImage?{
//        set(value){leftIconImageView.image = value}
//        get{return leftIconImageView.image}
//    }
//    
//    @IBInspectable var rightIcon:UIImage?{
//        set(value){iconImageView.image = value}
//        get{return iconImageView.image}
//    }
//    
//    @IBInspectable var isSecureTextEntry: Bool{
//        set(value){
//            contentTextField.isSecureTextEntry = value
//            
//            if value{
//                iconImageView.image = R.image.passwordVisible()
//            }else{
//                iconImageView.image = R.image.passwordInvisible()
//                
//            }
//            
//        }
//        get{
//            return contentTextField.isSecureTextEntry
//            
//        }
//    }
//    
//    @IBInspectable var isEditable: Bool{
//        set(value){contentTextField.isUserInteractionEnabled = value}
//        get{return contentTextField.isUserInteractionEnabled}
//    }
//    
//    @IBInspectable var maxLenght:Int{
//        set(value){contentMaxLenght = value}
//        get{return contentMaxLenght}
//    }
//    
//    @IBInspectable var labelFont:UIFont{
//        set(value){titleLabel.font = value}
//        get{return titleLabel.font}
//    }
//    
//    internal lazy var inputContainer:UIView  = {
//        return UIView().then{
//            $0.backgroundColor = R.color.textfieldContainerBackground()
//            $0.borderColor = R.color.inputBorder()
//            $0.borderWidth = 1
//            $0.customCornerRadius = 15
//        }
//    }()
//    
//    internal lazy var titleLabel: UILabel = {
//        return UILabel().then{
//            $0.numberOfLines = 0
//            $0.lineBreakMode = .byWordWrapping
//            $0.font = R.font.tomatoGroteskRegular(size: 14)!
//            $0.textColor  = R.color.inputContent()
//            $0.textAlignment = .left
//        }
//    }()
//    
//    internal lazy var contentTextField: UITextField =  {
//        return UITextField().then{
//            $0.font = R.font.tomatoGroteskMedium(size: 16)!
//            $0.textAlignment = .left
//            $0.tintColor = R.color.blackAndWhite()
//            $0.backgroundColor = R.color.textfieldContainerBackground()
//        }
//    }()
//    
//    
//    internal lazy var iconImageView:UIImageView = {
//        return UIImageView().then{
//            $0.contentMode = .scaleAspectFit
//        }
//    }()
//    
//    internal lazy var leftIconImageView:UIImageView = {
//        return UIImageView().then{
//            $0.contentMode = .scaleAspectFit
//        }
//    }()
//    
//    override init(frame: CGRect) {super.init(frame: frame)}
//    
//    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
//    
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setupView()
//    }
//    
//    
//    
//    /// Sets the UIKeyboard type for the content fieled
//    ///
//    /// - Parameter keyboardType: The desired UIKeyboard type
//    func setKeyBoardType(_ keyboardType:UIKeyboardType){
//        contentTextField.keyboardType = keyboardType
//    }
//    
//    func setmaxLenght(_ lenght:Int){
//        self.maxLenght = lenght
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text = textField.text ?? ""
//        let nsString = text as NSString
//        let newText = nsString.replacingCharacters(in: range, with: string)
//        textDidChange?(newText )
//        return newText.count <= maxLenght
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        //reset input field color for error
//        titleLabel.textColor  = UIColor.mintLabel()
//        inputContainer.borderColor = UIColor.mintBottomSheetBorderColor()
//        
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        didEndEditing?()
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return self.contentTextField.resignFirstResponder()
//    }
//    
//    private func setupView() {
//        
//        //add the label subview
//        addSubview(titleLabel)
//        addSubview(inputContainer)
//        inputContainer.addSubview(contentTextField)
//        inputContainer.addSubview(iconImageView)
//        inputContainer.addSubview(leftIconImageView)
//    
//        
//        titleLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview()
//            make.top.equalToSuperview().offset(8)
//            make.right.equalToSuperview()
//        }
//        
//        
//        inputContainer.snp.makeConstraints{make in
//            make.bottom.equalTo(titleLabel.snp_bottom).offset(50)
//            make.right.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.equalToSuperview()
//        }
//        
//        //add left icon
//        leftIconImageView.snp.makeConstraints{make in
//            make.left.equalToSuperview().inset(16)
//            make.centerY.equalToSuperview()
//        }
//        
//        contentTextField.snp.makeConstraints {make in
//            if leftIcon != nil {
//             make.left.equalTo(leftIconImageView).offset(20)
//            } else {
//             make.left.equalToSuperview().offset(8)
//            }
//            make.top.equalToSuperview().offset(8)
//            make.right.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(8)
//            make.height.equalTo(30).priority(1000)
//        }
//        
//        //add the right icon
//        iconImageView.snp.makeConstraints{make in
//            make.right.equalToSuperview().inset(16)
//            make.centerY.equalToSuperview()
//        }
//        
//        
//        
//        
//        contentTextField.delegate = self
//        
//        if isEditable{
//            //add a cick listener to focus on the contentTextField
//            self.inputContainer.addTapGestureRecognizer{
//                self.contentTextField.becomeFirstResponder()
//            }
//            
//            self.addTapGestureRecognizer{
//                self.contentTextField.becomeFirstResponder()
//            }
//        }
//        contentTextField.addTarget(self, action: #selector(self.textFieldTextChanged), for: .editingChanged)
//    }
//    
//    @objc private func textFieldTextChanged() {
//        self.textChanged?(content ?? "")
//    }
//}
