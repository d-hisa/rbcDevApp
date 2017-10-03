//
//  CategoryAddViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/02.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var pickerColorName: UIPickerView!
    @IBOutlet var pickerColorLevel: UIPickerView!
    @IBOutlet var sampleColorLabel:UILabel!
    //@IBOutlet var metadataTableView: UITableView!
    
    var azusaColorNum: Int = 0
    var azusaLevelNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerColorLevel.dataSource = self
        pickerColorLevel.delegate = self
        pickerColorName.dataSource = self
        pickerColorName.delegate = self

        // Do any additional setup after loading the view.
    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
