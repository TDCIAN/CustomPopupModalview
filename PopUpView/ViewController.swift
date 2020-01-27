//
//  ViewController.swift
//  PopUpView
//
//  Created by APPLE on 2020/01/27.
//  Copyright © 2020 JeongminKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // 컨테이너뷰가 등장할 때 얼마나 뜸들였다가 등장할지 결정한다 -> 10초 후 등장
        // 등장할 때는 popup.swift에서 설정해준 animateIn 메소드에서 설정해준 애니메이션대로 등장한다
        // 클릭하면 animateOut 메소드에서 설정해준 애니메이션대로 사라진다
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            let pop = Popup()
            self.view.addSubview(pop)
        }
    }


}

