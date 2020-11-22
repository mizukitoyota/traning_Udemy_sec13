//
//  NextViewController.swift
//  map_sec13
//
//  Created by Training on 2020/11/21.
//  Copyright © 2020 training. All rights reserved.
//緯度経度をデリゲートメソッドで渡して前画面に表示

import UIKit

//プロトコル
protocol SearchLocationDelegate {
    func serachLocation(idoValue:String,keidoValue:String)
}

class NextViewController: UIViewController {

    @IBOutlet weak var idoTextField: UITextField!
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //
    @IBAction func okAction(_ sender: Any) {
        //入力された値取得
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        //両方のテキストがからでなかれば戻る
        if idoTextField.text != nil && keidoTextField.text != nil {
            //デリゲートメソッド引数に入れる
            delegate?.serachLocation(idoValue: idoValue, keidoValue: keidoValue)
            dismiss(animated: true, completion: nil)
        }
    }
}
