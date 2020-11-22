//
//  ViewController.swift
//  map_sec13
//
//  Created by Training on 2020/11/21.
//  Copyright © 2020 training. All rights reserved.
//

import UIKit
//ツールボックス
import MapKit
import CoreLocation
//MobileGestalt.c：1647：地域情報を取得できませんでした



//CLLocation-システムによって報告される緯度、経度、およびコース情報   ,UIGesture-タッチオブジェクト使用可
class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate,SearchLocationDelegate {

    //住所入れる変数
    var adressString = ""
    //UILongPressGestureRecognizer-
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    //CLLocationManagerを宣言
    var logManerger: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton.backgroundColor = .white
        //角が丸くなる　cornerRadiusー
        settingButton.layer.cornerRadius = 20.0
        
    }
    //sender-アクション時に情報が入る(ロングタップ)
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        //state-状態
        if sender.state == .began{
            //タップ開始
            
        } else if sender.state == .ended {
            //タップ終了
            
            //タップした位置指定、MKマップ上の緯度経度取得
            
            //緯度軽度から住所に変更,ビュー内のロングタップのロケーション
            let tapPoint = sender.location(in: view)
            //タップした位置(cGPoint)を指定してMKmapview上の緯度経度を取得、ポイントどこタップしたポイント、どこのビューマップビュー
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            //緯度経度、convertメソッド使用（うえ）
            let lat = center.latitude
            let log = center.longitude
            //座標。、クロージャのなかにlat,logはいるplaceMark
            convert(lat: lat, log: log)
            
        }
    }
    //CLLocationDegrees緯度、CLLocationDegrees経度、
    //クロージャー、処理が終わった後（Placemark,error）に値が入る,selfつける
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude:lat,longitude:log)
        geocoder.reverseGeocodeLocation(location) {(placeMark,error) in
            //placeMarksが空で無いか
            if let placeMark = placeMark {
                //からで無いなら、placeMarkの住所が入っていたらtrue
                if let pm = placeMark.first {
                    //pmの（県とか取得）が入ってい時、または市名が入ってる時true
                    if pm.administrativeArea != nil || pm.locality != nil {
                        //住所欄にpmの値を入れる
                        self.adressString = pm.name! + pm.administrativeArea! + pm.locality!
                    } else  {
                        //県、市が入っていない場合こちら、単純な地名のみ
                        self.adressString = pm.name!
                        }
                    //アドレスラベルに反映
                    self.addressLabel.text = self.adressString
                }
            }
        }
    }
    
    @IBAction func gotoSearchVC(_ sender: Any) {
    //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //ストーリボード名
        if segue.identifier == "next" {
            //行き先
            let nextVC = segue.destination as! NextViewController
            //
        }
    }
    //まかされたデリゲートメソッド
    func serachLocation(idoValue: String, keidoValue: String) {
        if idoValue.isEmpty != true && keidoValue.isEmpty != true {
            let idoString = idoValue
            let keidoString = keidoValue
            //緯度経度からコーディネート
            let cordinate = CLLocationCoordinate2DMake(Double(idoString)!,Double(keidoString)! )
            //表示範囲指定 MKCoordinateSpan-
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            //領域指定 MKCoordinateRegion-
            let region = MKCoordinateRegion(center: cordinate, span: span)
            //領域をマップビューに設定 setRegion-
            mapView.setRegion(region, animated: true)
            //緯度経度から住所へ変換
            convert(lat: Double(idoString)!, log: Double(keidoString)! )
            //ラベルに表示
            addressLabel.text = adressString
        }else{
            addressLabel.text = "表示できません"
        }
    }
}

