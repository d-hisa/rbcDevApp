//
//  MetaDataEditViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/06.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MetaDataEditViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var freeNumNumwithLabel:UILabel!
    @IBOutlet var textField:UITextField!
    @IBOutlet var unitLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var colorRgbLabel:UILabel!
    @IBOutlet var sampleColorLabel:UILabel!
    @IBOutlet var rLabel:UILabel!
    @IBOutlet var gLabel:UILabel!
    @IBOutlet var bLabel:UILabel!
    @IBOutlet var rValueLabel:UILabel!
    @IBOutlet var gValueLabel:UILabel!
    @IBOutlet var bValueLabel:UILabel!
    @IBOutlet var rSlider:UISlider!
    @IBOutlet var gSlider:UISlider!
    @IBOutlet var bSlider:UISlider!
    @IBOutlet var presetColorLabel:UILabel!
    @IBOutlet var presetSwitch:UISwitch!
    @IBOutlet var colorNamePicker:UIPickerView!
    @IBOutlet var colorLevelPicker:UIPickerView!
    @IBOutlet var imageLabel:UILabel!
    @IBOutlet var imageDataView:UIImageView!
    
    // delegates
    var metadata:MetadataObject = MetadataObject()
    
    // private
    var azusaColorNum:Int = 0
    var azusaLevelNum:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rSlider.addTarget(self, action: #selector(self.onRChange), for: .valueChanged)
        gSlider.addTarget(self, action: #selector(self.onGChange), for: .valueChanged)
        bSlider.addTarget(self, action: #selector(self.onBChange), for: .valueChanged)
        colorNamePicker.delegate = self
        colorNamePicker.dataSource = self
        colorLevelPicker.delegate = self
        colorLevelPicker.dataSource = self
        initViewParts()
        
    }
    
    func onRGBChange(){
        onRChange()
        onGChange()
        onBChange()
    }
    func onRChange(){
        rValueLabel.text = String(Int(rSlider.value))
        sampleColorLabel.backgroundColor = UIColor(red: CGFloat(rSlider.value/255), green: CGFloat(gSlider.value/255), blue: CGFloat(bSlider.value/255), alpha: 1)
    }
    func onGChange(){
        gValueLabel.text = String(Int(gSlider.value))
        sampleColorLabel.backgroundColor = UIColor(red: CGFloat(rSlider.value/255), green: CGFloat(gSlider.value/255), blue: CGFloat(bSlider.value/255), alpha: 1)
    }
    func onBChange(){
        bValueLabel.text = String(Int(bSlider.value))
        sampleColorLabel.backgroundColor = UIColor(red: CGFloat(rSlider.value/255), green: CGFloat(gSlider.value/255), blue: CGFloat(bSlider.value/255), alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViewParts(){
        // common sets
        textField.text = metadata.mText
        datePicker.setDate(metadata.mDate, animated: true)
        rSlider.setValue((metadata.mColor?.componentsF.redF)!, animated: true)
        bSlider.setValue((metadata.mColor?.componentsF.greenF)!, animated: true)
        gSlider.setValue((metadata.mColor?.componentsF.blueF)!, animated: true)
        sampleColorLabel.backgroundColor = metadata.mColor
        imageDataView.image = metadata.mImage

        let type = MetadataObject.mType.self
        let thisType:String = metadata.mType
        switch thisType{
        case type.dateFormat.rawValue:
            labelDisabling(label: freeNumNumwithLabel)
            textField.isEnabled = false
            unitLabel.isHidden = true
            labelDisabling(label: colorRgbLabel)
            labelDisabling(label: sampleColorLabel)
            rLabel.textColor = UIColor.gray
            gLabel.textColor = UIColor.gray
            bLabel.textColor = UIColor.gray
            rSlider.isEnabled = false
            gSlider.isEnabled = false
            bSlider.isEnabled = false
            rValueLabel.textColor = UIColor.gray
            gValueLabel.textColor = UIColor.gray
            bValueLabel.textColor = UIColor.gray
            labelDisabling(label: presetColorLabel)
            presetSwitch.isEnabled = false
            colorNamePicker.isUserInteractionEnabled = false
            colorLevelPicker.isUserInteractionEnabled = false
            labelDisabling(label: imageLabel)
            imageDataView.isUserInteractionEnabled = false
        case type.imageFormat.rawValue:
            labelDisabling(label: freeNumNumwithLabel)
            textField.isEnabled = false
            unitLabel.isHidden = true
            labelDisabling(label: dateLabel)
            datePicker.isUserInteractionEnabled = false
            labelDisabling(label: colorRgbLabel)
            labelDisabling(label: sampleColorLabel)
            rLabel.textColor = UIColor.gray
            gLabel.textColor = UIColor.gray
            bLabel.textColor = UIColor.gray
            rSlider.isEnabled = false
            gSlider.isEnabled = false
            bSlider.isEnabled = false
            rValueLabel.textColor = UIColor.gray
            gValueLabel.textColor = UIColor.gray
            bValueLabel.textColor = UIColor.gray
            labelDisabling(label: presetColorLabel)
            presetSwitch.isEnabled = false
            colorNamePicker.isUserInteractionEnabled = false
            colorLevelPicker.isUserInteractionEnabled = false
            imageDataView.image = Defaults().image
            imageDataView.isUserInteractionEnabled = true
            imageDataView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped(_:))))
        case type.colorFormat.rawValue:
            labelDisabling(label: freeNumNumwithLabel)
            textField.isEnabled = false
            unitLabel.isHidden = true
            labelDisabling(label: dateLabel)
            datePicker.isUserInteractionEnabled = false
            rSlider.setValue(Float((metadata.mColor?.components.red)!) * 255, animated: true)
            gSlider.setValue(Float((metadata.mColor?.components.green)!) * 255, animated: true)
            bSlider.setValue(Float((metadata.mColor?.components.blue)!) * 255, animated: true)
            colorNamePicker.isUserInteractionEnabled = false
            colorLevelPicker.isUserInteractionEnabled = false
            labelDisabling(label: imageLabel)
            imageDataView.isUserInteractionEnabled = false
        default: // free/num/numWith
            if thisType == type.numericWithUnitFormat.rawValue{
                textField.text = String(metadata.mValue)
                unitLabel.text = metadata.mText
                textField.keyboardType = .decimalPad
                textField.becomeFirstResponder()
            }else if thisType == type.numericFormat.rawValue{
                textField.text = String(metadata.mValue)
                unitLabel.isHidden = true
                textField.keyboardType = .decimalPad
                textField.becomeFirstResponder()
            }else{
                textField.text = metadata.mText
                unitLabel.isHidden = true
                textField.keyboardType = .default
                textField.becomeFirstResponder()
            }
            labelDisabling(label: dateLabel)
            datePicker.isUserInteractionEnabled = false
            labelDisabling(label: colorRgbLabel)
            labelDisabling(label: sampleColorLabel)
            rLabel.textColor = UIColor.gray
            gLabel.textColor = UIColor.gray
            bLabel.textColor = UIColor.gray
            rSlider.isEnabled = false
            gSlider.isEnabled = false
            bSlider.isEnabled = false
            rValueLabel.textColor = UIColor.gray
            gValueLabel.textColor = UIColor.gray
            bValueLabel.textColor = UIColor.gray
            labelDisabling(label: presetColorLabel)
            presetSwitch.isEnabled = false
            colorNamePicker.isUserInteractionEnabled = false
            colorLevelPicker.isUserInteractionEnabled = false
            labelDisabling(label: imageLabel)
            imageDataView.isUserInteractionEnabled = false
        }
        
    }
    func labelDisabling(label:UILabel){
        label.textColor = AZSColor().getColor(color: AZSColor.color.gray, level: AZSColor.level.medium)
        label.backgroundColor = AZSColor().getColor(color: AZSColor.color.gray, level: AZSColor.level.light)
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn{
            rLabel.textColor = UIColor.gray
            gLabel.textColor = UIColor.gray
            bLabel.textColor = UIColor.gray
            rSlider.isEnabled = false
            gSlider.isEnabled = false
            bSlider.isEnabled = false
            rValueLabel.textColor = UIColor.gray
            gValueLabel.textColor = UIColor.gray
            bValueLabel.textColor = UIColor.gray
            colorNamePicker.isUserInteractionEnabled = true
            colorLevelPicker.isUserInteractionEnabled = true
        }else{
            rLabel.textColor = UIColor.black
            gLabel.textColor = UIColor.black
            bLabel.textColor = UIColor.black
            rSlider.isEnabled = true
            gSlider.isEnabled = true
            bSlider.isEnabled = true
            rValueLabel.textColor = UIColor.black
            gValueLabel.textColor = UIColor.black
            bValueLabel.textColor = UIColor.black
            colorNamePicker.isUserInteractionEnabled = false
            colorLevelPicker.isUserInteractionEnabled = false
        }
    }
    
    // Pickers
    // Pickerに表示する列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Pcikerに表示する行数を設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count:Int
        if pickerView == colorNamePicker{
            count = AZSColor.color.count
        }else{
            count = AZSColor.level.count
        }
        return count
    }
    // Pickerに表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result :String
        if pickerView == colorNamePicker{
            result = AZSColor().colorName[row]
        }else{
            result = AZSColor().levelName[row]
        }
        return result
    }
    // Pickerを選択したときにSampleLabelの色を変更
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorNamePicker{
            azusaColorNum = row
        }else{
            azusaLevelNum = row
            
        }
        let bgColor:UIColor = AZSColor().getColor(colorN: azusaColorNum, levelN: azusaLevelNum)
        sampleColorLabel.backgroundColor = bgColor
        let txColor:UIColor = AZSColor().getTextColor(colorN: azusaColorNum, levelN: azusaLevelNum)
        sampleColorLabel.textColor = txColor
        rSlider.value = Float(bgColor.components.red * 255)
        gSlider.value = Float(bgColor.components.green * 255)
        bSlider.value = Float(bgColor.components.blue * 255)
        onRGBChange()
    }
    
    // ImagePIcker
    func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageDataView.image = image
        self.dismiss(animated: true)
    }
    
    @IBAction func okTap(){        
        let type = MetadataObject.mType.self
        let thisType:String = metadata.mType
        switch thisType{
        case type.freeFormat.rawValue:
            metadata.mText = textField.text!
        case type.numericFormat.rawValue:
            if textField.text!.isNumericOnly(){
                metadata.mValue = Double(textField.text!)!
            }else{
                util().showErrorAlert(title: "半角数字以外が入力されています", message: "数値は半角数字のみで入力してください", vc: self)
            }
            
        case type.numericWithUnitFormat.rawValue:
            if textField.text!.isNumericOnly(){
                metadata.mValue = Double(textField.text!)!
            }else{
                util().showErrorAlert(title: "半角数字以外が入力されています", message: "数値は半角数字のみで入力してください", vc: self)
            }
        case type.dateFormat.rawValue:
            metadata.mDate = datePicker.date
        case type.imageFormat.rawValue:
            metadata.mImage = imageDataView.image!
        case type.colorFormat.rawValue:
            metadata.mColor = sampleColorLabel.backgroundColor!
        default:
            metadata.mText = textField.text!
        }
        let tab = self.presentingViewController as? UITabBarController
        let nav = tab?.selectedViewController as? UINavigationController
        let vc = nav?.viewControllers.last as! InputContentDataViewController
        vc.updateTableView()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelTap(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
