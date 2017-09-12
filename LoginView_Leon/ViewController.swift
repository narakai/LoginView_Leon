//
//  ViewController.swift
//  LoginView_Leon
//
//  Created by lai leon on 2017/9/12.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width

class ViewController: UIViewController {

    let passnameField: UITextField = {
        let passnameField = UITextField(frame: CGRect(x: 20, y: YHHeight / 2, width: YHWidth - 40, height: 30))
        passnameField.modificationTextField(placeholder: "请输入手机号", keyboardType: .numberPad, text: nil)
        return passnameField
    }()

    let passwordField: UITextField = {
        let passwordField = UITextField(frame: CGRect(x: 20, y: YHHeight / 2 + 40, width: YHWidth - 40, height: 30))
        passwordField.modificationTextField(placeholder: "请输入密码", keyboardType: .asciiCapable, text: nil)
        passwordField.isSecureTextEntry = true
        return passwordField
    }()

    let loginBtn: UIButton = {
        let loginBtn = UIButton(frame: CGRect(x: 20, y: YHHeight / 2 + 30 * 2 + 30, width: YHWidth - 40, height: 30))
        loginBtn.modificationButton(title: "登录")
        return loginBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }


    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(passnameField)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHiden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func keyboardWillShow(note: Notification) {
        let keyboardHeight = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        Log("键盘高度：\(keyboardHeight)")
        if keyboardHeight / 2 == -view.frame.origin.y {
            Log("无需再次移动！")
            return
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight / 2, width: YHWidth, height: YHHeight)
        }
    }


    func keyboardWillHiden(note: Notification) {
        if view.frame.origin.x == 0 {
            Log("无需再次复位！")
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = YHRect
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
