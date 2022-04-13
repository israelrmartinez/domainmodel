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
        if curr == "GBP" {
            newMoney *= (0.5 / 2)
        }
        let newAmount = Int(newMoney)
        print(newMoney)
        return Money(amount: newAmount, currency: curr)
    }
    
    func add() {
        
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
