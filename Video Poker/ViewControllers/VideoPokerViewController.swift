//
//  ViewController.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import UIKit

class VideoPokerViewController: UIViewController {
    
    // Variables
    var presenter: PokerPresenter
    var currentHand: [Card] = []
    
    var dealButton: UIButton!
    var cardStackView = UIStackView()
    var cardImageViews: [UIImageView] = []
    
    init(presenter: PokerPresenter = PokerPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - UI Construction
extension VideoPokerViewController {
    private func setupUI() {
        addDealButton()
        addCardStackView()
    }
    
    private func addDealButton() {
       dealButton = {
            let button = UIButton()
            button.setTitle("Deal Cards", for: .normal)
            button.backgroundColor = UIColor(red: 9/255, green: 137/255, blue: 227/255, alpha: 1)
            button.addTarget(self, action: #selector(dealButtonWasTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        view.addSubview(dealButton)
        dealButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        dealButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dealButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dealButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addCardStackView() {
        view.addSubview(cardStackView)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        cardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        cardStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        cardStackView.bottomAnchor.constraint(equalTo: dealButton.topAnchor, constant: -25).isActive = true
        cardStackView.axis = .horizontal
        cardStackView.alignment = .fill
        cardStackView.spacing = 3
        cardStackView.distribution = .fillEqually
    }

    private func addCards() {
        for card in currentHand {
            let cardView = UIImageView()
            cardView.image = UIImage(named: "\(card.rank)_\(card.suit)")
            cardView.backgroundColor = .white
            cardStackView.addArrangedSubview(cardView)
        }
    }

}

// MARK: - Button Actions
extension VideoPokerViewController {
    @objc private func dealButtonWasTapped() {
        currentHand = presenter.deal()
        addCards()
    }
}
