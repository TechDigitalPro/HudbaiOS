import Foundation
import UIKit
import JGProgressHUD
import Alamofire
import Toast_Swift

func showLoading(){
    hud.show(in: appDelegate.window!)
}

func hideLoading(){
    hud.dismiss()
}

func apiPost(_ url: String, _ param: [String: Any], _ completion: @escaping ((_ res: AnyObject) -> ())){
    let httpHeaders : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
    let task = Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody, headers: httpHeaders)
        .responseJSON { response in
            DispatchQueue.main.async { hideLoading() }
            switch response.result {
            case .success(let data):
                if response.response?.statusCode == 200{
                    completion(data as AnyObject)
                    return
                }else{
                    print("\nBad Response")
                    alert("Error", "Bad Response!", "Try again later"){ res in }
                }
                break
            case .failure(_):
                print("\nCommunication Error")
                alert("Error", "Communication Error!", "Try again later"){ res in }
                break
            }
            print(url)
            print(String(data: response.data!, encoding: .utf8)!)
    }
    task.resume()
}

func apiGet(_ url: String,  _ completion: @escaping ((_ res: AnyObject) -> ())){
    let httpHeaders : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
    let task = Alamofire.request(url, method: .get, encoding: URLEncoding.httpBody, headers: httpHeaders)
        .responseJSON { response in
            DispatchQueue.main.async { hideLoading() }
            switch response.result {
            case .success(let data):
                if response.response?.statusCode == 200{
                    completion(data as AnyObject)
                    return
                }else{
                    print("\nBad Response")
                    alert("Error", "Bad Response!", "Try again later"){ res in }
                }
                break
            case .failure(_):
                print("\nCommunication Error")
                alert("Error", "Communication Error!", "Try again later"){ res in }
                break
            }
            print(url)
            print(String(data: response.data!, encoding: .utf8)!)
    }
    task.resume()
}

func alert(_ title:String, _ text: String, _ actions: String,  _ completion: @escaping ((_ res: String) -> ())){
    let alertController = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
    let actionArry = actions.split(separator: ",")
    for item in actionArry{
        let bTitle = "\(item)"
        alertController.addAction(UIAlertAction(title: bTitle, style: .default, handler: { action in
            completion(bTitle as String)
        }))
    }
    appDelegate.window!.rootViewController!.present(alertController, animated: true, completion: nil)
}

func showToast(_ message: String){
    appDelegate.window!.makeToast(message)
}

func showToast(_ pVC: UIViewController, _ title: String, _ message: String, _ backColor: UIColor, _ foreColor: UIColor, _ bottom: Double, _ delegate: ToastDelegate?){
    if let vc = pVC.storyboard?.instantiateViewController(withIdentifier: "ToastVC") as? ToastVC{
        vc.sTitle = title
        vc.message = message
        vc.backColor = backColor
        vc.foreColor = foreColor
        vc.bottom = bottom
        vc.delegate = delegate
        pVC.present(vc, animated: false, completion: nil)
    }
}
