```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi
```

Q: SwiftUI Preview SKProduct with introductoryPrice (by Dan)

A: They are open classes so the solution is just to use inheritance, like in below demo.

So you can construct and set up your `MockSK*` entities as you with and pass everywhere, where real `SK*` instances expected.

```
import StoreKit

class MockSKProductSubscriptionPeriod: SKProductSubscriptionPeriod {
    private let _numberOfUnits: Int
    private let _unit: SKProduct.PeriodUnit

    init(numberOfUnits: Int = 1, unit: SKProduct.PeriodUnit = .year) {
        _numberOfUnits = numberOfUnits
        _unit = unit
    }

    override var numberOfUnits: Int {
        self._numberOfUnits
    }

    override var unit: SKProduct.PeriodUnit {
        self._unit
    }
}

class MockSKProduct: SKProduct {
    private var _subscriptionPeriod: SKProductSubscriptionPeriod

    init(subscriptionPeriod: SKProductSubscriptionPeriod = MockSKProductSubscriptionPeriod()) {
        _subscriptionPeriod = subscriptionPeriod
    }

    override var subscriptionPeriod: SKProductSubscriptionPeriod? {
        get {
            _subscriptionPeriod
        }
    }
}
```
