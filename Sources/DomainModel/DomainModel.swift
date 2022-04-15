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
    var title: String
    var type: JobType
    
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
    
    func raise(byAmount: Int) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double) * byAmount
        case .Salary(let UInt):
            return Int(UInt) + byAmount
        }
    }
    
    func raise(byAmount: Double) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double) * Int(byAmount)
        case .Salary(let UInt):
            return Int(UInt) + Int(byAmount)
        }
    }
    
    func raise(byPercent: Double) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double) * Int(1 + byPercent)
        case .Salary(let UInt):
            return Int(UInt) * Int(1 + byPercent)
        }
    }
    
    func convert() -> Job {
        let newJob = Job(title: title, type: Job.JobType.Salary(2000))
        
        return newJob
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?
    var spouse: Person?
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    init(firstName: String, age: Int) {
        self.firstName = firstName
        self.lastName = ""
        self.age = age
    }
    
    init(lastName: String, age: Int) {
        self.firstName = ""
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        return String("[Person: firstName: \(firstName) lastName: \(lastName) age: \(age) job: \(job) spouse: \(spouse)]")
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
    
    init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse?.firstName != spouse2.firstName) {
            spouse1.spouse = spouse2
        } else if (spouse2.spouse?.firstName != spouse1.firstName) {
            spouse2.spouse = spouse1
        }
        self.members = [spouse1, spouse2]
    }
    
    func haveChild(_ parent: Person) -> Bool {
        if parent.age > 20 {
            return true
        } else {
            return false
        }
    }
    
    func householdIncome() -> Int {
        var totalIncome = 0
        for person in members {
            let annualIncome = person.job?.calculateIncome(2000) ?? 0
            totalIncome += annualIncome
        }
        return totalIncome
    }
}
