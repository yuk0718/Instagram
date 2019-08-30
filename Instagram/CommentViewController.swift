//
//  CommentViewController.swift
//  Instagram
//
//  Created by 須田幸秀 on 2019/08/18.
//  Copyright © 2019 yukihide.suda. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!
    var resArray: [String] = []
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        //データベース呼び出し
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        
        //入力内容を取得。左が投稿者名、右がコメント内容
        let res = "\(Auth.auth().currentUser!.displayName!) :\n\(textField.text!)"
        
        //データベース上のコメントを取得し、上記の新しいコメントを追加する
        resArray = postData.comment
        resArray.append(res)
        
        //上記で追加したコメントを含め、データベースに登録する
        let comment = ["comment": resArray]
        postRef.updateChildValues(comment)
                
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
