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
        amount = am
        currency = curr
    }
    
    func convert(_ curr: String) -> Money {
        var newMoney: Double = Double(amount)
        let gbpToUsd = Int(newMoney / 0.5)
        let eurToUsd = Int(newMoney / 1.5)
        let canToUsd = Int(newMoney / 1.25)
        var gbpMoney: Money
        var eurMoney: Money
        var canMoney: Money
        
        if curr != "USD" {
            if curr == "GBP" {
                newMoney *= 0.5
            } else if curr == "EUR" {
                newMoney *= 1.5
            } else if curr == "CAN" {
                newMoney *= 1.25
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
        if currency == "USD" {
            if mon.currency == "GBP" {
                newMoney = self.convert("GBP")
                newMoney.amount += mon.amount
                newMoney.currency = "GBP"
            } else if mon.currency == "EUR" {
                newMoney = self.convert("EUR")
                newMoney.amount += mon.amount
                newMoney.currency = "EUR"
            } else if mon.currency == "CAN" {
                newMoney = self.convert("EUR")
                newMoney.amount += mon.amount
                newMoney.currency = "CAN"
            } else {
                newMoney.amount += self.amount
            }
            return newMoney
        }
        let gbpMoney = mon.convert("GBP")
        let eurMoney = mon.convert("EUR")
        let canMoney = mon.convert("CAN")
        
        if currency == "GBP" {
            return gbpMoney
        } else if currency == "EUR" {
            return eurMoney
        } else {
            return canMoney
        }
//        newMoney.amount += mon.amount
//        newMoney.currency = "USD"
//
//        return newMoney
    }
    
    func subtract() {
        
    }
}

//let mon = Money(amount: 4, currency: "USD")
//print(mon.convert("GBP"))


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
//        switch type {
//        case .Hourly(let double):
//            return double * time
//        }
//        case .Salary(let UInt) {
//            return Int(UInt)
//        }
        return time
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
