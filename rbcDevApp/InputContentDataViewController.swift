//
//  InputContentDataViewController.swift
//  rbcDevApp
//
//  Created by Daiki Hisazawa on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import RealmSwift

class InputContentDataViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var metadataTableView:UITableView!
    @IBOutlet var titleField:UITextField!
    @IBOutlet var categorylabel: UILabel!
    @IBOutlet var contentImage:UIImageView!
    
    var categoryName: String = ""
    var categoryObj:CategoryObject = CategoryObject()
    var tempMetadataObjArray:[MetadataObject] = []
    var selectedIndexPathRow:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryObj.decodeData()
        if tempMetadataObjArray.count > 0{
            //already tempMetadataObjArray initialized.
        }else{
            for i in 0..<categoryObj.metaDataPresetsObjArray.count{
                let type = MetadataObject.mType.self
                let thisType:String = categoryObj.metaDataPresetsObjArray[i].mpFormat
                let mName:String = categoryObj.metaDataPresetsObjArray[i].mpName
                let mUnit:String = categoryObj.metaDataPresetsObjArray[i].mpUnit
                switch thisType{
                case type.freeFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.freeFormat.rawValue, text: ""))
                case type.numericFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.numericFormat.rawValue, value: 0))
                case type.numericWithUnitFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.numericWithUnitFormat.rawValue, value: 0, text: mUnit))
                case type.dateFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.dateFormat.rawValue, date: Defaults().todayDate))
                case type.imageFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.imageFormat.rawValue, image: UIImage()))
                case type.colorFormat.rawValue:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.colorFormat.rawValue, color: UIColor.white))
                default:
                    tempMetadataObjArray.append(MetadataObject(name: mName, type: type.freeFormat.rawValue, text: ""))
                }
            }
        }
        titleField.placeholder = "content name"
        categorylabel.text = categoryObj.catName
        categorylabel.backgroundColor = categoryObj.catBackColor
        categorylabel.textColor = categoryObj.catTextColor
        contentImage.image = Defaults().image
        contentImage.isUserInteractionEnabled = true
        contentImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(InputContentDataViewController.imageViewTapped(_:))))
        metadataTableView.delegate = self
        metadataTableView.dataSource = self
        metadataTableView.tableFooterView = UIView()
        let nib : UINib = UINib(nibName:"MetadataInputTableViewCell",bundle: Bundle.main)
        metadataTableView.register(nib, forCellReuseIdentifier: "metaDataEditCell")
    }
    func imageViewTapped(_ sender: UITapGestureRecognizer) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // ビューに表示する
        self.contentImage.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
        metadataTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryObj.metaDataPresetsObjArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metaDataEditCell", for: indexPath) as! MetadataInputTableViewCell
        let targetMetadataObj = tempMetadataObjArray[indexPath.row]
        let dataType:String = targetMetadataObj.mType
        let mType = MetadataObject.mType.self
        // init cell
        cell.metadataTitleLabel.text = targetMetadataObj.mName
        cell.unitTitleLabel.isHidden = true
        cell.unitLabel.isHidden = true
        cell.metaImageView.isHidden = true
        cell.backgroundColor = UIColor.white
        switch dataType {
        case mType.freeFormat.rawValue:
            cell.elementTitleLabel.text = "Text"
            cell.elementLabel.text = targetMetadataObj.mText
        case mType.numericFormat.rawValue:
            cell.elementTitleLabel.text = "Value"
            cell.elementLabel.text = String(targetMetadataObj.mValue)
        case mType.numericWithUnitFormat.rawValue:
            cell.elementTitleLabel.text = "Value"
            cell.elementLabel.text = String(targetMetadataObj.mValue)
            cell.unitTitleLabel.isHidden = false
            cell.unitTitleLabel.text = "Unit"
            cell.unitLabel.isHidden = false
            cell.unitLabel.text = targetMetadataObj.mText
        case mType.dateFormat.rawValue:
            cell.elementTitleLabel.text = "Date"
            cell.elementLabel.text = targetMetadataObj.mDate.date2stringY4M2D2sepSrash()
        case mType.imageFormat.rawValue:
            cell.elementTitleLabel.isHidden = true
            cell.elementLabel.isHidden = true
            cell.metaImageView.isHidden = false
            cell.metaImageView.image = targetMetadataObj.mImage
        case mType.colorFormat.rawValue:
            cell.elementTitleLabel.isHidden = true
            cell.elementLabel.text = "Color"
            cell.backgroundColor = targetMetadataObj.mColor
        default:
            cell.elementTitleLabel.text = "Cannot Readable Format."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPathRow = indexPath.row
        self.performSegue(withIdentifier: "toMetadataEditModal", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func updateTableView(){
        metadataTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toMetadataEditModal"?:
            if ((segue.destination as! MetaDataEditViewController) != nil){
                let metaDataEditDataViewController = segue.destination as! MetaDataEditViewController
                metaDataEditDataViewController.metadata = tempMetadataObjArray[selectedIndexPathRow]
            }
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    @IBAction func saveContent(){
        if titleField.text! == ""{
            util().showErrorAlert(title: "コンテンツ名が空白です", message: "コンテンツ名は必須です", vc: self)
            return
        }
        let realm = try! Realm()
        let contentObj:ContentObject = ContentObject()
        contentObj.conName = titleField.text!
        contentObj.conImage = contentImage.image!
        for tMOA in tempMetadataObjArray{tMOA.mBelongingContent = contentObj.conName}
        contentObj.conBelongingCategory = categoryObj.catName
        contentObj.conMetadataObjArray = tempMetadataObjArray
        contentObj.encodeData()
        try! realm.write {
            realm.add(contentObj)
        }
        let alert = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                alert.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "returnAddContentView", sender: self)
            })
        })
        //self.performSegue(withIdentifier: "returnAddContentView", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }

}
