//
//  popup.swift
//  PopUpView
//
//  Created by APPLE on 2020/01/27.
//  Copyright © 2020 JeongminKim. All rights reserved.
//

import UIKit

class Popup: UIView {
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "1 Credit"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "in app purchase for one book credit"
        label.textAlignment = .center
        // numberOfLines를 추가해주면 글씨가 화면을 넘어가 ...으로 바뀌는 상황을 해결해준다
        label.numberOfLines = 3
        return label
    }()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()
    
    // lazy var로 선언해줘야 스택뷰 안에 아직 이니셜라이즈되지 않은 두 레이블을 넣을 수 있다
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    // 화면에서 사라지게 하는 애니메이션 메소드
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            // 탭을 했을 때 컨테이너뷰가 위로 사라진다
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0 // 이게 안 들어가 있으면 컨테이너뷰가 사라질 때까지 화면이 투명하게 변하지 않는다
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    // 최초에 등장할 때 적용되는 애니메이션
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 사라지게 하는 animateOut 메소드를 탭으로 실행할 수 있도록 제스쳐리코그나이저를 넣어준다
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateOut)))
        
        // 배경색을 주면서 동시에 알파값을 부여해 반투명의 배경색을 만든다
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
        // UIScreen.main.bounds를 넣어주면 뷰컨트롤러에서 사용했을 때 알아서 테두리에 사이즈를 맞춘다
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        // 컨테이너뷰의 위치와 크기를 설정
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        // 뷰에 들어갈 레이블들을 담고 있는 스택뷰의 위치를 설정
        container.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        
        // 등장하는 애니메이션을 실행시킨다
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
