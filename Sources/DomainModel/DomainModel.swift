import Foundation

struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    
    init(amount am: Int, currency curr: String) {
        self.amount = am
        self.currency = curr
    }
    
    func convert(_ curr: String) -> Money {
        var newMoney: Double = Double(amount)
        let gbpToUsd = Int((0.25 * 2) * newMoney)
        let eurToUsd = Int((2 * 1.5) * newMoney)
        let canToUsd = Int((4 * 1.25) * newMoney)
        var gbpMoney: Money
        var eurMoney: Money
        var canMoney: Money
        
        if curr != "USD" {
            if curr == "GBP" {
                newMoney *= (0.5 / 2)
            } else if curr == "EUR" {
                newMoney *= (1.5 / 2)
            } else if curr == "CAN" {
                newMoney *= (1.25 / 4)
            }
            let newAmount = Int(newMoney)
            return Money(amount: newAmount, currency: curr)
        }
        gbpMoney = Money(amount: gbpToUsd, currency: curr)
        eurMoney = Money(amount: eurToUsd, currency: curr)
        canMoney = Money(amount: canToUsd, currency: curr)
        if currency == "GBP" {
            return gbpMoney
        } else if currency == "EUR" {
            return eurMoney
        } else {
            return canMoney
        }
    }
    
    func add(_ mon: Money) -> Money {
        var newMoney: Money = mon
        if currency != "USD" {
            newMoney = mon.convert("USD")
            if mon.currency == "GBP" {
                newMoney.amount += mon.amount
                newMoney.currency = "GBP"
            } else if mon.currency == "EUR" {
                newMoney.amount += mon.amount
                newMoney.currency = "GBP"
            } else {
                newMoney.amount += mon.amount
                newMoney.currency = "CAN"
            }
            return newMoney
        }
        newMoney.amount += mon.amount
        newMoney.currency = "USD"
        
        return newMoney
    }
    
    func subtract(_ mon: Money) -> Money {
        var newMoney: Money = mon
        if currency != "USD" {
            newMoney = mon.convert("USD")
            if mon.currency == "GBP" {
                newMoney.amount -= mon.amount
                newMoney.currency = "GBP"
            } else if mon.currency == "EUR" {
                newMoney.amount -= mon.amount
                newMoney.currency = "GBP"
            } else {
                newMoney.amount -= mon.amount
                newMoney.currency = "CAN"
            }
            return newMoney
        }
        newMoney.amount -= mon.amount
        newMoney.currency = "USD"
        
        return newMoney
    }
}


////////////////////////////////////
// Job
//
public class Job {
    let title: String
    let type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome(_ time: Int) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double) * time
        case .Salary(let UInt):
            return Int(UInt)
        }
    }
    
    func raise(byAmount: Int) {
        // type =
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
