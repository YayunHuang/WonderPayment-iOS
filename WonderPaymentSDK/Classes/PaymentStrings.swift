extension String {
    var i18n: String {
        return PaymentStrings.get(self)
    }
}

class PaymentStrings {
    
    static func get(_ key: String) -> String {
        let locale = WonderPayment.paymentConfig.locale
        let res: Dictionary<String, String>
        switch (locale) {
        case .en_US:
            res = en_US
        case .zh_CN:
            res = zh_CN
        case .zh_HK:
            res = zh_HK
        }
        return res[key] ?? key
        
    }
    
    static let en_US = [
        "paymentMethod": "Payment method",
        "selectPaymentMethod": "Select a payment method",
        "securedCheckout": "Secured Checkout",
        "hailDiscount": "Street Hail Discount",
        "enjoyStreetHail": "Bind major credit cards issued in Hong Kong to enjoy street hail with",
        "serviceFee": "100% Service Fee",
        "unfinishedPayment": "Unfinished Payment",
        "whySeeingThis": "Why am I seeing this?",
        "payment": "Payment",
        "status": "Status",
        "pending": "Pending",
        "initiatedAt": "Payment initiated at",
        "pendingPayment": "Pending Payment Status",
        "pendingPaymentDesc":
"""
The reason why you're seeing this status is because there might be a pending payment initiated (commonly when you initiate Wechat Pay or Alipay). What to do:

 1. If you have successfully made the payment, please come back and check the payment status shortly later.

 2. If you have dropped out of the payment process, you can either complete the unfinished payment or make another payment.
""",
        "paymentFailed": "Payment failed. Please try again",
        "retryPayment": "Retry Payment",
        "successfulPayment": "Successful Payment",
        "card": "Card",
        "date": "Date",
        "totalAmount": "Total Amount",
        "cardNumber": "Card Number",
        "inputCardNumber": "Input Card Number",
        "expiryDate": "Expiry Date",
        "firstName": "Cardholder First Name",
        "inputFirstName": "Input Cardholder First Name",
        "lastName": "Cardholder Last Name",
        "inputLastName":"Input Cardholder Last Name",
        "phoneNumber": "Cardholder Phone Number",
        "inputPhoneNumber": "Input Phone Number",
        "saveCardInfo": "Save this Card Information",
        "confirm": "Confirm",
        "cardPayment": "Card Payment",
        "back": "Back",
        "dialingCode": "Dialing Code",
        "search":"Search",
        "cvv": "CVV",
        "pay": "Pay",
        "wechatPay": "Wechat Pay",
        "alipay": "Alipay",
        "alipayHK": "Alipay HK",
        "applePay": "Apple Pay",
        "unionPay": "UnionPay Wallet",
        "cancel": "Cancel",
        "save": "Save",
        "networkError": "Network Error",
        "unknownError": "Unknown Error",
        "dataFormatError": "Data Format Error",
        "processing": "Processing The Transaction...",
        "doNotClose": "Please don't close or refresh",
        "willAutoRedirect": "This page will automatically redirect",
        "required": "Required",
        "enterValidNumber": "Please enter a valid credit card number",
        "enterValidExpiry": "Enter valid expiry date",
        "enterValidCVV": "Enter valid CVV",
        "nameShouldNot": "Name should not include numbers and special characters",
        "invalidPhone": "Invalid Phone Number",
        "saveThisCard": "Save this Card",
        "cardVerified": "Card verified",
        "canStartPaying": "You can start paying with this card",
        "closeSession": "Close Payment Session?",
        "sureToLeave": "You haven’t finished the payment.Are you sure you want to leave?",
        "continuePayment": "Continue the Payment",
        "paymentAmount": "Payment Amount",
        "transactionID": "Transaction ID",
        "RRN": "RRN",
        "customerName": "Customer Name",
        "transactionTime": "Transaction Time",
        "invoiceAmount": "Invoice Amount",
    ]
    
    static let zh_CN = [
        "paymentMethod": "支付方式",
        "selectPaymentMethod": "选择一种支付方式",
        "securedCheckout": "安全结帐",
        "hailDiscount": "路边招手优惠",
        "enjoyStreetHail": "将香港发行的主要信用卡绑定，即可享受路边招手优惠",
        "serviceFee": "100% 服务费",
        "unfinishedPayment": "未完成付款",
        "whySeeingThis": "为什么我会看到这个？",
        "payment": "支付方式",
        "status": "支付状态",
        "pending": "未完成",
        "initiatedAt": "支付创建",
        "pendingPayment": "待支付状态",
        "pendingPaymentDesc":
"""
您看到这个状态的原因可能是因为有待支付的款项（通常是当您启动微信支付或支付宝时）。处理方法如下：

 1. 如果您已成功完成支付，请稍后回来检查支付状态。

 2. 如果您中途放弃了支付流程，您可以选择完成未完成的支付，或进行另一笔支付。
""",
        "paymentFailed": "支付失败，请再试一次",
        "retryPayment": "重新支付",
        "successfulPayment": "支付成功",
        "card": "卡",
        "date": "日期",
        "totalAmount": "总金额",
        "cardNumber": "信用卡号码",
        "inputCardNumber": "请输入信用卡号码",
        "expiryDate": "有效期",
        "firstName": "持卡人姓氏",
        "inputFirstName": "请输入持卡人姓氏",
        "lastName": "持卡人名字",
        "inputLastName":"请输入持卡人名字",
        "phoneNumber": "持卡人手机号",
        "inputPhoneNumber": "请输入手机号",
        "saveCardInfo": "保存卡片信息",
        "confirm": "确定",
        "cardPayment": "信用卡支付",
        "back": "返回",
        "dialingCode": "区号",
        "search":"搜索",
        "cvv": "CVV",
        "pay": "付款",
        "wechatPay": "微信支付",
        "alipay": "支付宝",
        "alipayHK": "支付宝 香港",
        "unionPay": "云闪付",
        "applePay": "Apple Pay",
        "cancel": "取消",
        "save": "保存",
        "networkError": "网络异常",
        "unknownError": "未知异常",
        "dataFormatError": "数据格式错误",
        "processing": "交易处理中...",
        "doNotClose": "请不要关闭或刷新页面",
        "willAutoRedirect": "页面将自动跳转",
        "required": "必填",
        "enterValidNumber": "请输入一个有效的信用卡号码",
        "enterValidExpiry": "请输入有效的到期日期",
        "enterValidCVV": "请输入有效的CVV",
        "nameShouldNot": "姓名不能包含数字和特殊字符",
        "invalidPhone": "无效的手机号码",
        "saveThisCard": "保存卡片",
        "cardVerified": "卡片已验证",
        "canStartPaying": "您可以开始用这张卡付款",
        "closeSession": "关闭付款会话？",
        "sureToLeave": "您尚未完成付款。您确定要离开吗？",
        "continuePayment": "继续付款",
        "paymentAmount": "付款金额",
        "transactionID": "交易ID",
        "RRN":"RRN",
        "customerName": "客户名称",
        "transactionTime": "交易时间",
        "invoiceAmount": "发票金额",
    ]
    
    static let zh_HK = [
        "paymentMethod": "支付方式",
        "selectPaymentMethod": "選擇一種支付方式",
        "securedCheckout": "安全結帳",
        "hailDiscount": "路邊招手優惠",
        "enjoyStreetHail": "將香港發行的主要信用卡綁定，即可享有路邊招手優惠",
        "serviceFee": "100% 服務費",
        "unfinishedPayment": "未完成付款",
        "whySeeingThis": "為什麼我會看到這個？",
        "payment": "支付方式",
        "status": "支付狀態",
        "pending": "未完成",
        "initiatedAt": "支付創建",
        "pendingPayment": "待支付狀態",
        "pendingPaymentDesc":
"""
您看到這個狀態的原因可能是因為有待支付的款項（通常是當您啟動微信支付或支付寶時）。處理方法如下：

 1. 如果您已成功完成支付，請稍後回來檢查支付狀態。

 2. 如果您中途放棄了支付流程，您可以選擇完成未完成的支付，或進行另一筆支付。
""",
        "paymentFailed": "支付失敗，請再試一次",
        "retryPayment": "重新支付",
        "successfulPayment": "支付成功",
        "card": "卡",
        "date": "日期",
        "totalAmount": "總金額",
        "cardNumber": "信用卡號碼",
        "inputCardNumber": "請輸入信用卡號碼",
        "expiryDate": "有效期",
        "firstName": "持卡人姓氏",
        "inputFirstName": "請輸入持卡人姓氏",
        "lastName": "持卡人名字",
        "inputLastName":"請輸入持卡人名字",
        "phoneNumber": "持卡人手機號碼",
        "inputPhoneNumber": "請輸入手機號碼",
        "saveCardInfo": "保存卡片信息",
        "confirm": "確定",
        "cardPayment": "信用卡支付",
        "back": "返回",
        "dialingCode": "區號",
        "search":"搜索",
        "cvv": "CVV",
        "pay": "付款",
        "wechatPay": "微信支付",
        "alipay": "支付寶",
        "alipayHK": "支付寶 香港",
        "unionPay": "雲閃付",
        "applePay": "Apple Pay",
        "cancel": "取消",
        "save": "保存",
        "networkError": "網絡異常",
        "unknownError": "未知異常",
        "dataFormatError": "數據格式錯誤",
        "processing": "交易處理中...",
        "doNotClose": "請不要關閉或刷新頁面",
        "willAutoRedirect": "頁面將自動跳轉",
        "required": "必填",
        "enterValidNumber": "請輸入一個有效的信用卡號碼",
        "enterValidExpiry": "請輸入有效的到期日期",
        "enterValidCVV": "請輸入有效的CVV",
        "nameShouldNot": "姓名不能包含數字和特殊字符",
        "invalidPhone": "無效的手機號碼",
        "saveThisCard": "保存卡片",
        "cardVerified": "卡片已驗證",
        "canStartPaying": "您可以開始用這張卡付款",
        "closeSession": "關閉付款會話？",
        "sureToLeave": "您尚未完成付款。您確定要離開嗎？",
        "continuePayment": "繼續付款",
        "paymentAmount": "付款金額",
        "transactionID": "交易ID",
        "RRN": "RRN",
        "customerName": "客戶名稱",
        "transactionTime": "交易時間",
        "invoiceAmount": "發票金額",
    ]
}
