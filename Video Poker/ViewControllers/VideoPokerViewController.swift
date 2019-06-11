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
    
    var dealerButton: UIButton!
    var cardStackView = UIStackView()
    var heldCards: Deck = []
    
    init(presenter: PokerPresenter = PokerPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 223/255, green: 230/255, blue: 233/255, alpha: 1)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - UI Construction
extension VideoPokerViewController {
    private func setupUI() {
        addDealerButton()
        addCardStackView()
    }
    
    private func addDealerButton() {
       dealerButton = {
            let button = UIButton()
            button.setTitle("Deal Cards", for: .normal)
            button.backgroundColor = UIColor(red: 9/255, green: 137/255, blue: 227/255, alpha: 1)
            button.addTarget(self, action: #selector(dealerButtonWasTapped), for: .touchUpInside)
            button.tag = 1
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        view.addSubview(dealerButton)
        dealerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        dealerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dealerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dealerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addCardStackView() {
        view.addSubview(cardStackView)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        cardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        cardStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        cardStackView.bottomAnchor.constraint(equalTo: dealerButton.topAnchor, constant: -25).isActive = true
        cardStackView.axis = .horizontal
        cardStackView.alignment = .fill
        cardStackView.spacing = 3
        cardStackView.distribution = .fillEqually
    }

    private func addCards() {
        if cardStackView.arrangedSubviews.count > 0 {
            for subview in cardStackView.arrangedSubviews {
                subview.removeFromSuperview()
            }
        }
        
        for (index, card) in presenter.currentHand.enumerated() {
            let cardView = UIImageView()
            cardView.image = UIImage(named: "\(card.rank)_\(card.suit)")
            cardView.backgroundColor = .white
            let tapGesutre = UITapGestureRecognizer(target: self, action: #selector(didTapPlayingCard))
            tapGesutre.numberOfTapsRequired = 1
            cardView.tag = index
            cardView.isUserInteractionEnabled = true
            cardView.addGestureRecognizer(tapGesutre)
            cardStackView.addArrangedSubview(cardView)
        }
    }
    
    @objc private func didTapPlayingCard(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else { return }
        let tappedCard = presenter.currentHand[cardView.tag]
        let alertController = UIAlertController(title: "\(tappedCard.rank) of \(tappedCard.suit)", message: "What would you like to do?", preferredStyle: .actionSheet)
        let keepAction = UIAlertAction(title: "Keep", style: .default) { (_) in
            self.presenter.heldCards.append(self.presenter.currentHand[cardView.tag])
            self.addGoButton()
        }
        let discardAction = UIAlertAction(title: "Discard", style: .default) { (_) in
            self.presenter.discardedCards.append(self.presenter.currentHand[cardView.tag])
        }
        alertController.addAction(keepAction)
        alertController.addAction(discardAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func addGoButton() {
        dealerButton.setTitle("Go", for: .normal)
        dealerButton.isHidden = false
        dealerButton.tag = 2
    }
    
    private func removeTapGestures() {
        for subview in cardStackView.subviews {
            guard let recognizers = subview.gestureRecognizers else { return }
            for recognizer in recognizers {
                subview.removeGestureRecognizer(recognizer)
            }
        }
    }

}

// MARK: - Button Actions
extension VideoPokerViewController {
    @objc private func dealerButtonWasTapped(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                presenter.currentHand = presenter.deal()
                addCards()
                dealerButton.isHidden = true
            case 2:
                presenter.discardAndGetNewCards()
                removeTapGestures()
                addCards()
                dealerButton.isHidden = true
            default:
                return
        }
    }
}
