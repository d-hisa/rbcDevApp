//
//  CategoryAddViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/02.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var pickerColorName: UIPickerView!
    @IBOutlet var pickerColorLevel: UIPickerView!
    @IBOutlet var sampleColorLabel:UILabel!
    @IBOutlet var metadataTableView: UITableView!
    @IBOutlet var editableSwitch:UISwitch!
    
    struct tmpMetaData{
        var name:String = ""
        var unit:String = ""
        var format:String = ""
        init(name:String,format:String,unit:String){
            self.name = name
            self.format = format
            self.unit = unit
        }
    }
    var azusaColorNum: Int = 0
    var azusaLevelNum: Int = 0
    var tmpMetadataArray: [tmpMetaData] = []
    var MetadataPresetObjArray: [MetadataPresetObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metadataTableView.dataSource = self
        metadataTableView.delegate = self
        pickerColorLevel.dataSource = self
        pickerColorLevel.delegate = self
        pickerColorName.dataSource = self
        pickerColorName.delegate = self
        metadataTableView.tableFooterView = UIView()
        let nib : UINib = UINib(nibName:"CategoryMetadataPresetTableViewCell",bundle: Bundle.main)
        metadataTableView.register(nib, forCellReuseIdentifier: "metaDataPresetCell")
    }
    
    // Pickers
    // Pickerに表示する列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Pcikerに表示する行数を設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count:Int
        if pickerView == pickerColorName{
            count = AZSColor.color.count
        }else{
            count = AZSColor.level.count
        }
        return count
    }
    // Pickerに表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result :String
        if pickerView == pickerColorName{
            result = AZSColor().colorName[row]
        }else{
            result = AZSColor().levelName[row]
        }
        return result
    }
    // Pickerを選択したときにSampleLabelの色を変更
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerColorName{
            azusaColorNum = row
        }else{
            azusaLevelNum = row
            
        }
        sampleColorLabel.backgroundColor = AZSColor().getColor(colorN: azusaColorNum, levelN: azusaLevelNum)
        sampleColorLabel.textColor = AZSColor().getTextColor(colorN: azusaColorNum, levelN: azusaLevelNum)
    }
    // Pickers
    
    
    // TableViews
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MetadataPresetObjArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metaDataPresetCell", for: indexPath) as! CategoryMetadataPresetTableViewCell
        cell.numberingLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = MetadataPresetObjArray[indexPath.row].mpName
        cell.formatLabel.text = MetadataPresetObjArray[indexPath.row].mpFormat
        cell.unitLabel.text = MetadataPresetObjArray[indexPath.row].mpUnit
        return cell
    }
    // Cellをタップしたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingMetadataAlert(selectedRow: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        metadataTableView.reloadData()
    }
    // 削除可能なセルを設定（すべてを許可）
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // TableView

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // スイッチの挙動
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn{
            metadataTableView.isEditing = true
        }else{
            metadataTableView.isEditing = false
        }
    }
    // editされた時
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // テーブルの元データアレイを更新
        MetadataPresetObjArray.remove(at: indexPath.row)
        // テーブルビューを更新
        metadataTableView.reloadData()
    }
    
    // Cancelボタンを押したときの挙動
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setCategoryName(category:CategoryObject){
        category.catName = titleTextField.text!
        for i in 0..<MetadataPresetObjArray.count{
            MetadataPresetObjArray[i].mpBelongCategory = category.catName
        }
    }
    // Saveボタンを押したときの挙動
    // カテゴリをRealmDBへ保存
    @IBAction func saveCategory2Realm(){
        if titleTextField.text! == ""{
            showErrorAlert(num: 1)
            return
        }
        let realm = try! Realm()
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        let categoryObject: CategoryObject = CategoryObject()
        setCategoryName(category: categoryObject)
        categoryObject.catBackColor = sampleColorLabel.backgroundColor!
        categoryObject.catTextColor = sampleColorLabel.textColor!
        //convertTmp2Obj()
        categoryObject.metaDataPresetsObjArray = MetadataPresetObjArray
        categoryObject.encodeData()
        
        if let result:Results = realm.objects(CategoryObject.self).filter("catName like '" + categoryObject.catName + "'"){
            if result.count > 0{
                showErrorAlert(num: 0)
                return
            }else{
                try! realm.write {
                    realm.add(categoryObject)
                }
            }
        }else{
            showErrorAlert(num: 99)
            return
        }

        /*
        try! realm.write {
            realm.add(categoryObject)
        }*/
        // 親VCを取り出し、テーブルのビュー更新処理を叩く
        //let ppvc = presentingViewController as! CategoryListViewController
        let tab = self.presentingViewController as? UITabBarController
        let nav = tab?.selectedViewController as? UINavigationController
        let vc = nav?.viewControllers.last as! CategoryListViewController
        vc.updateTableView()
        /*
        if let parentVC = presentingViewController as! CategoryListViewController!{
            parentVC.updateTableView()
        }*/
        
        
        self.dismiss(animated: true, completion: nil)
        /*
        let result:Results = realm.objects(CategoryObject.self).filter("catName like " + categoryObject.catName)
        //print(result)
        if result.count > 0{
            showErrorAlert()
        }else{
            try! realm.write {
                realm.add(categoryObject)
            }
            self.dismiss(animated: true, completion: nil)
        }*/
    }
    
    func showErrorAlert(num:Int){
        var title: String = ""
        var message:String = ""
        switch num {
        case 0:
            title = "カテゴリ名が重複しています！"
            message = "カテゴリ名はユニークでなければなりません"
        case 1:
            title = "カテゴリ名が未入力です"
            message = "カテゴリ名は他と重複しないユニークな名称を設定してください"
        default:
            title = "不明なエラーです"
            message = "開発者にお問い合わせください"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(cancelAction)
        //よくわからんおまじない
        alert.view.setNeedsLayout()
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
        metadataTableView.reloadData()
    }
    
    // メタデータ追加ボタン
    @IBAction func addMetadata(){
        let defaultMetadata:MetadataPresetObject = MetadataPresetObject(
            name: "metadata" + String(MetadataPresetObjArray.count + 1),
            format: "none",
            unit: "-",
            withCategory: "")
        MetadataPresetObjArray.append(defaultMetadata)
        metadataTableView.reloadData()
        if MetadataPresetObjArray.count > 3 {
            let nos = metadataTableView.numberOfSections
            let nor = metadataTableView.numberOfRows(inSection: nos-1)
            let lastPath:IndexPath = IndexPath(row: nor-1, section: nos-1)
            metadataTableView.scrollToRow( at: lastPath , at: .bottom, animated: true)
        }
    }
    // metadataをAlertでセットする
    func settingMetadataAlert(selectedRow:Int) {
        // テキストフィールド付きアラート表示
        let alert = UIAlertController(
            title: "MetaData" + String(selectedRow) + "の名前とフォーマットを設定してください",
            message: "UnitはNumericWithUnitフォーマットのみサポートしています",
            preferredStyle: .alert)
        
        // 各種フォーマットボタンの設定
        let freeFomratAction = UIAlertAction(title: "Free Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit = "-"
            self.MetadataPresetObjArray[selectedRow].mpFormat = "freeFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(freeFomratAction)
        let numericFomratAction = UIAlertAction(title: "Numeric Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit = "-"
            self.MetadataPresetObjArray[selectedRow].mpFormat = "numericFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(numericFomratAction)
        let numericWithUnitFomratAction = UIAlertAction(title: "Numeric with Unit Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit =  alert.textFields![1].text!
            self.MetadataPresetObjArray[selectedRow].mpFormat = "numericWithUnitFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(numericWithUnitFomratAction)
        let dateFomratAction = UIAlertAction(title: "Date Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit = "-"
            self.MetadataPresetObjArray[selectedRow].mpFormat = "dateFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(dateFomratAction)
        let colorFomratAction = UIAlertAction(title: "Color Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit = "-"
            self.MetadataPresetObjArray[selectedRow].mpFormat = "colorFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(colorFomratAction)
        let imageFomratAction = UIAlertAction(title: "Image Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.MetadataPresetObjArray[selectedRow].mpName =  alert.textFields![0].text!
            self.MetadataPresetObjArray[selectedRow].mpUnit = "-"
            self.MetadataPresetObjArray[selectedRow].mpFormat = "imageFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(imageFomratAction)

        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "MetaData name"
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "Unit"
        })
        //よくわからんおまじない
        alert.view.setNeedsLayout()
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
        metadataTableView.reloadData()
    }
    
    
    func labelUnabling(label:UILabel){
        label.isEnabled = false
        label.textColor = UIColor.gray
    }
    func labelEnabling(label:UILabel){
        label.isEnabled = true
        label.textColor = UIColor.black
    }
}
