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
    
    init(presenter: PokerPresenter = PokerPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        view.backgroundColor = UIColor(red: 223/255, green: 230/255, blue: 233/255, alpha: 1)
        setupUI()
    }
}

extension VideoPokerViewController: GameDelegate {
    func displaySelectAllError() {
        let alertController = UIAlertController(title: "Error", message: "You must choose to keep or discard on every card", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            self.changeToGoButton()
        }
        
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func shouldShowGoButton() {
        changeToGoButton()
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

        for subview in cardStackView.arrangedSubviews {
            subview.removeFromSuperview()
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

    private func changeToGoButton() {
        dealerButton.setTitle("Go", for: .normal)
        dealerButton.isHidden = false
        dealerButton.tag = 2
    }

    /*
     Once the user has discard and redrawn cards one time we should not allow them to
     keep doing this, since it is against the rules.
    */
    private func removeTapGestures() {
        for subview in cardStackView.arrangedSubviews {
            guard let recognizers = subview.gestureRecognizers else { return }
            for recognizer in recognizers {
                subview.removeGestureRecognizer(recognizer)
            }
        }
    }
    
    private func checkScore() {
        let score = presenter.score()
        let alertController = UIAlertController(title: "Game Result", message: "\(score)", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            self.dealerButton.setTitle("Deal Cards", for: .normal)
            self.dealerButton.isHidden = false
            self.dealerButton.tag = 1
        }
        
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - Button Actions
extension VideoPokerViewController {
    @objc private func dealerButtonWasTapped(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                presenter.resetGame()
                presenter.currentHand = presenter.deal()
                addCards()
                dealerButton.isHidden = true
            case 2:
                presenter.discardAndGetNewCards()
                addCards()
                removeTapGestures()
                dealerButton.isHidden = true
                checkScore()
            default:
                return
        }
    }

    @objc private func didTapPlayingCard(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view else { return }
        let tappedCard = presenter.currentHand[cardView.tag]
        let alertController = UIAlertController(title: "\(tappedCard.rank) of \(tappedCard.suit)", message: "What would you like to do?", preferredStyle: .actionSheet)
        let keepAction = UIAlertAction(title: "Keep", style: .default) { (_) in
            self.presenter.heldCards.append(self.presenter.currentHand[cardView.tag])
            let subviews = self.cardStackView.arrangedSubviews
            let currentSubView = subviews[cardView.tag]
            currentSubView.layer.borderWidth = 3
            currentSubView.layer.borderColor = UIColor.green.cgColor
            self.presenter.shouldShowGoButton()
        }
        let discardAction = UIAlertAction(title: "Discard", style: .default) { (_) in
            self.presenter.discardedCards.append(self.presenter.currentHand[cardView.tag])
            let subviews = self.cardStackView.arrangedSubviews
            let currentSubView = subviews[cardView.tag]
            currentSubView.layer.borderWidth = 3
            currentSubView.layer.borderColor = UIColor.red.cgColor
            self.presenter.shouldShowGoButton()
        }
        alertController.addAction(keepAction)
        alertController.addAction(discardAction)
        present(alertController, animated: true, completion: nil)
    }

}
