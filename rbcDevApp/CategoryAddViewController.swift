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
        return tmpMetadataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metaDataPresetCell", for: indexPath) as! CategoryMetadataPresetTableViewCell
        cell.numberingLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = tmpMetadataArray[indexPath.row].name
        cell.formatLabel.text = tmpMetadataArray[indexPath.row].format
        cell.unitLabel.text = tmpMetadataArray[indexPath.row].unit
        return cell
    }
    // Cellをタップしたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingMetadataAlert(selectedRow: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        metadataTableView.reloadData()
    }
    // TableView

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Cancelボタンを押したときの挙動
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // Saveボタンを押したときの挙動
    @IBAction func save(){
        // save process
        self.dismiss(animated: true, completion: nil)
    }
    // メタデータ追加ボタン
    @IBAction func addMetadata(){
        let defaultMetadata:tmpMetaData = tmpMetaData(
            name: "metadata" + String(tmpMetadataArray.count + 1),
            format: "none",
            unit: "-")
        tmpMetadataArray.append(defaultMetadata)
        metadataTableView.reloadData()
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
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit = "-"
            self.tmpMetadataArray[selectedRow].format = "freeFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(freeFomratAction)
        let numericFomratAction = UIAlertAction(title: "Numeric Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit = "-"
            self.tmpMetadataArray[selectedRow].format = "numericFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(numericFomratAction)
        let numericWithUnitFomratAction = UIAlertAction(title: "Numeric with Unit Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit =  alert.textFields![1].text!
            self.tmpMetadataArray[selectedRow].format = "numericWithUnitFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(numericWithUnitFomratAction)
        let dateFomratAction = UIAlertAction(title: "Date Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit = "-"
            self.tmpMetadataArray[selectedRow].format = "dateFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(dateFomratAction)
        let colorFomratAction = UIAlertAction(title: "Color Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit = "-"
            self.tmpMetadataArray[selectedRow].format = "colorFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(colorFomratAction)
        let imageFomratAction = UIAlertAction(title: "Image Format", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            self.tmpMetadataArray[selectedRow].name =  alert.textFields![0].text!
            self.tmpMetadataArray[selectedRow].unit = "-"
            self.tmpMetadataArray[selectedRow].format = "imageFormat"
            self.metadataTableView.reloadData()
        })
        alert.addAction(imageFomratAction)

        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "MetaData name"
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "Unit"
        })
        
        
        // 複数追加したいならその数だけ書く
        // alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        //     textField.placeholder = "テキスト"
        // })
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
