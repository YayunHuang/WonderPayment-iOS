//
//  PaymentsViewController.swift
//  PaymentSDK
//
//  Created by Levey on 2024/3/1.
//

import UIKit

enum PaymentStatus {
    case normal,pending,error,success
}

class PaymentsViewController: UIViewController {
    
    ///支付参数
    var intent: PaymentIntent! {
        didSet {
            let amountText = "\(CurrencySymbols.get(intent.currency))\(formatAmount(intent.amount))"
            mView.amountLabel.text = amountText
            if !selectMode {
                let buttonText = "\("pay".i18n) \(amountText)"
                mView.methodView.cardConfirmButton.setTitle(buttonText, for: .normal)
                mView.bankCardView.confirmButton.setTitle(buttonText, for: .normal)
            }
        }
    }
    ///支付回调
    var callback: PaymentResultCallback!
    ///选择模式
    var selectMode = false
    
    lazy var mView = PaymentsView(selectMode: selectMode)
    var paymentStatus: PaymentStatus = .normal {
        didSet {
            mView.setUIStatus(paymentStatus)
        }
    }
    
    /// 上次支付的PaymentIntent，重试时使用
    var lastPaymentIntent: PaymentIntent?
    
    override func loadView() {
        self.view = mView
        mView.setUIStatus(paymentStatus)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        gestureRecognizer.cancelsTouchesInView = false
        UIApplication.shared.keyWindow?.addGestureRecognizer(gestureRecognizer)
        mView.titleBar.rightView.addTarget(self, action:#selector(close(_:)), for: .touchUpInside)
        mView.errorView.retryButton.addTarget(self, action:#selector(retry(_:)), for: .touchUpInside)
        mView.methodView.addCardButton.addTarget(self, action:#selector(showAddCard(_:)), for: .touchUpInside)
        mView.bankCardView.backButton.addTarget(self, action:#selector(hideAddCard(_:)), for: .touchUpInside)
        mView.methodView.unionPayButton.addTarget(self, action:#selector(unionPay(_:)), for: .touchUpInside)
        mView.methodView.wechatPayButton.addTarget(self, action:#selector(wechatPay(_:)), for: .touchUpInside)
        mView.methodView.alipayButton.addTarget(self, action:#selector(alipay(_:)), for: .touchUpInside)
        mView.methodView.alipayHKButton.addTarget(self, action:#selector(alipayHK(_:)), for: .touchUpInside)
        mView.methodView.cardConfirmButton.addTarget(self, action: #selector(cardConfirmed(_:)), for: .touchUpInside)
        mView.bankCardView.confirmButton.addTarget(self, action: #selector(addCardConfirmed(_:)), for: .touchUpInside)
        loadData()
    }
    
    private func loadData() {
        PaymentService.queryCardList {
            [weak self] cards, error in
            self?.mView.methodView.setCardItems(cards ?? [])
        }
    }
    
    private func resetUI() {
        mView.scrollView.qmui_scrollToTop()
        mView.showAddCard = false
        self.view.endEditing(true)
    }
    
    @objc func onTap(_ sender: UIView) {
        self.view.endEditing(true)
    }
    
    @objc func close(_ sender: UIButton) {
        self.dismiss(animated: true)
        callback(PaymentResult(status: .canceled))
    }
    
    @objc func showAddCard(_ sender: UIButton) {
        mView.showAddCard = true
    }
    
    @objc func hideAddCard(_ sender: UIButton) {
        mView.showAddCard = false
        self.view.endEditing(true)
    }
    
    ///重新支付
    @objc func retry(_ sender: UIButton) {
        if let intent = lastPaymentIntent {
            pay(intent: intent, delegate: self)
        }
    }
    
    @objc func wechatPay(_ sender: UIButton) {
        let paymentIntent = intent.copy()
        paymentIntent.paymentMethod = PaymentMethod(type: .wechat, arguments: [
            "in_app": [ "app_id": "wxb75a8cfd1068e40c"]
        ])
        pay(intent: paymentIntent, delegate: self)
    }
    
    @objc func alipay(_ sender: UIButton) {
        let paymentIntent = intent.copy()
        paymentIntent.paymentMethod = PaymentMethod(type: .alipay, arguments: [
            "in_app": [
                "app_env": "ios",
                "payment_inst": "ALIPAYCN",
            ]
        ])
        pay(intent: paymentIntent, delegate: self)
    }
    
    @objc func alipayHK(_ sender: UIButton) {
        let paymentIntent = intent.copy()
        paymentIntent.paymentMethod = PaymentMethod(type: .alipayHK, arguments: [
            "in_app": [
                "app_env": "ios",
                "payment_inst": "ALIPAYHK",
            ]
        ])
        pay(intent: paymentIntent, delegate: self)
    }
    
    @objc func unionPay(_ sender: UIButton) {
        let paymentIntent = intent.copy()
        paymentIntent.paymentMethod = PaymentMethod(type: .unionPay, arguments: ["in_app":[:] ])
        pay(intent: paymentIntent, delegate: self)
    }
    
    /// 卡片选中确认
    @objc func cardConfirmed(_ sender: UIButton) {
        if selectMode {
            
        } else {
            let cardInfo = mView.methodView.selectedCard
            let firstName = cardInfo?.holderFirstName ?? ""
            let lastName = cardInfo?.holderLastName ?? ""
            let expYear = cardInfo?.expYear ?? ""
            let expMonth = cardInfo?.expMonth ?? ""
            let args: [String : Any?] = [
                "exp_date": "\(expYear)\(expMonth)",
                "exp_year": expYear,
                "exp_month": expMonth,
                "number": cardInfo?.number,
                "token": cardInfo?.token,
                "holder_name": cardInfo?.holderName,
                "card_reader_mode": "manual",
                "billing_address": [
                    "first_name": firstName,
                    "last_name": lastName,
                    "phone_number": cardInfo?.phone,
                ],
            ]
            cardPay(args)
        }
    }
    
    /// 添加卡片确认
    @objc func addCardConfirmed(_ sender: UIButton) {
        if selectMode {
            
        } else {
            let form = mView.bankCardView.form
            let expDate = form.expDate
            let arr = expDate.split(separator: "/")
            let expYear = arr.first
            let expMonth = arr.last
            let args: [String : Any?] = [
                "exp_date": expDate.replace("/", with: ""),
                "exp_year": expYear,
                "exp_month": expMonth,
                "number": form.number,
                "cvv": form.cvv,
                "holder_name": "\(form.firstName) \(form.lastName)",
                "card_reader_mode": "manual",
                "billing_address": [
                    "first_name": form.firstName,
                    "last_name": form.lastName,
                    "phone_number": form.phone,
                ],
                "is_auto_save": form.save,
            ]
            cardPay(args)
        }
    }
    
    private func cardPay(_ args: [String: Any?]) {
        let paymentIntent = intent.copy()
        paymentIntent.paymentMethod = PaymentMethod(type: .creditCard, arguments: args)
        pay(intent: paymentIntent, delegate: self)
    }
    
}

extension PaymentsViewController: PaymentDelegate {
    func onInterrupt(intent: PaymentIntent) {
        LoadingView.dismiss()
        paymentStatus = .pending
        resetUI()
        let name: String
        switch(intent.paymentMethod?.type) {
        case .unionPay:
            name = "unionPay".i18n
        case.wechat:
            name = "wechatPay".i18n
        case .alipay:
            name = "alipay".i18n
        case .alipayHK:
            name = "alipayHK".i18n
        default:
            name = ""
            
        }
        mView.pendingView.paymentItem.value = name
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "MMM d, yyyy\nh:mm:ss a"
        let dateTime = dateFormatter.string(from: date)
        mView.pendingView.initAtItem.value = dateTime
    }
    
    func onProcessing() {
        LoadingView.show()
    }
    
    func onFinished(intent: PaymentIntent, result: PayResult?, error: ErrorMessage?) {
        resetUI()
        LoadingView.dismiss()
        lastPaymentIntent = intent
        if let error = error {
            paymentStatus = .error
            mView.errorView.errorMessage = error
        }
        if let result = result,let success = result.success, success {
            callback(PaymentResult(status: .completed))
            self.dismiss(animated: true)
        }
    }
}