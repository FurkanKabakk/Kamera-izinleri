//
//  ViewController.swift
//  CameraPermission
//
//  Created by furkan on 21.07.2023.
//  Bu uygulamamızda arkaplan resmimiz kameraden çekilen fotoğraf olacak ve gerekli tüm izinler tamamlanmış olacak.

import UIKit
import AVFoundation

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    @IBAction func openCameraCliced(_ sender: Any) {
        statusKamera()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        backgroundImage.image = image
        self.dismiss(animated: true)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        }
    }
    
    func statusKamera(){
        var status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            openCamera()
        case .restricted:
            makeAlert(titleInput: "Kameraya Erişilemiyor", messageInput: "Erişimi sağlamak için Ayarlar kısmınına gitmelisiniz")
        case .denied:
            makeAlert(titleInput: "Kameraya Erişilemiyor", messageInput: "Erişimi sağlamak için Ayarlar kısmınına gitmelisiniz")
        case .authorized:
            openCamera()
        }
    }
        
    func goSettings(alert:UIAlertAction){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)else{return}
        
        if UIApplication.shared.canOpenURL(settingsUrl){
            if #available(iOS 10.0, *){
                UIApplication.shared.open(settingsUrl)
            }else{
                UIApplication.shared.openURL(settingsUrl)
            }
        }
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        let settingsButton = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: goSettings)
        alert.addAction(okButton)
        alert.addAction(settingsButton)
        present(alert, animated: true)
    }
}
    


