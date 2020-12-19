//
//  TopViewController.swift
//  DivingMemoriesApp
//
//  Created by 白石裕幸 on 2020/10/18.
//

import UIKit
import AuthenticationServices
import FirebaseFirestore
import CryptoKit//暗号化
import Firebase
import FirebaseAuth

import PKHUD//


class TopViewController: UIViewController {

    
    
 


    let CreatUserDB = Firestore.firestore()
   
    
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //ナビゲーションを非表示
       self.navigationController?.isNavigationBarHidden = true
        
        
        let AutoOption:UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: AutoOption) { (_, _) in
            
            print("OKKKKKK")
            
            
        }
        
        
        
        
        // （②レイアウトを作成する）（IOS13以降のみ使えるので、そのように制限）・・・アップルボタンのレイアウトいじれる所あまりない・・・

        if #available(iOS 13.0, *) {
            // ここでインスタンス(ボタン)を生成
            let appleLoginButton = ASAuthorizationAppleIDButton(
                authorizationButtonType: .default,
                authorizationButtonStyle: .whiteOutline
            )
            // ボタン押した時にhandleTappedAppleLoginButtonの関数を呼ぶようにセット
            appleLoginButton.addTarget(
                self,
                action: #selector(handleTappedAppleLoginButton(_:)),
                for: .touchUpInside
            )
            
            
            // ↓はレイアウトの設定
            // これを入れないと下の方で設定したAutoLayoutが崩れる
            appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
            // Viewに追加
            view.addSubview(appleLoginButton)
            
            // ↓はAutoLayoutの設定
            // appleLoginButtonの中心を画面の中心にセットする
            appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            // appleLoginButtonの幅は、親ビューの幅の0.7倍
            appleLoginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
            // appleLoginButtonの高さは40
            appleLoginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        }
    }
    
    

    // ③appleLoginButtonを押した時の挙動を設定
    @available(iOS 13.0, *)
    @objc func handleTappedAppleLoginButton(_ sender: ASAuthorizationAppleIDButton) {
        // ランダムの文字列を生成
        let nonce = randomNonceString()
        // delegateで使用するため代入
        currentNonce = nonce
        // requestを作成
        let request = ASAuthorizationAppleIDProvider().createRequest()
        // sha256で変換したnonceをrequestのnonceにセット
        request.nonce = sha256(nonce)
        // controllerをインスタンス化する(delegateで使用するcontroller)
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    // ④randomで文字列を生成する関数を作成
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    // ⑤SHA256を使用してハッシュ変換する関数を用意
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    //キャンセル
    @IBAction func handleBackViewButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //シミュレータだとアップルログインができないから、一旦強制でログイン
    @IBAction func login(_ sender: Any) {
        
        
        
        let email = "shiraishi242@gmail.com"
           let password = "adgjmptw042"

           Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
               guard let self = self else { return }
            if (result?.user) != nil {
                self.performSegue(withIdentifier: "HOME", sender: nil)
                print("OK")
                   // サインイン後の画面へ
               }
              print("エラー")
           }

        
        
        
        
        
    }
    
    
}


// ⑥extensionでdelegate関数に追記していく
extension TopViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // 認証が成功した時に呼ばれる関数
    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // credentialが存在するかチェック
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        // nonceがセットされているかチェック
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        // credentialからtokenが取得できるかチェック
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        // tokenのエンコードを失敗
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        // 認証に必要なcredentialをセット
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idTokenString,
            rawNonce: nonce
        )
        // Firebaseへのログインを実行
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                // 必要に応じて
                HUD.flash(.labeledError(title: "予期せぬエラー", subtitle: "再度お試しください。"), delay: 1)
                return
            }
            if let authResult = authResult {
                print(authResult)
                // 必要に応じて
                HUD.flash(.labeledSuccess(title: "ログイン完了", subtitle: nil), onView: self.view, delay: 1) { _ in
                    // 画面遷移など行う
                    self.performSegue(withIdentifier: "HOME", sender: nil)
                    
                }
            }
        }
    }
    
    // delegateのプロトコルに設定されているため、書いておく
    func presentationAnchor(for _: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    // Appleのログイン側でエラーがあった時に呼ばれる
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
    
}
//loginPass
