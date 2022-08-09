
//The book shows the implamentation using a super class with abstract methods
protocol Duck {
    var name: String {get set}
    var quack: Quackable {get set}
    var fly: Flyable {get set}
    var swim: Swimmable {get set}
    
    func display()
    func performQuack()
    func performFly()
    func performSwim()
    
///These methods should be pulled out from the protocol since not all the ducks could fly, quack or swim
//    func quack()
//    func swim()
//    func fly()
}

///Adding default implementations as in the book
///Thease default implementations should also be left out since all the duck types cant use some behaviours
//extension Duck {
//    func quack() {
//        print("Duck is Quacking......!!!")
//    }
//    func swim() {
//        print("The duck is swimming.....!!!")
//    }
//}

extension Duck {
    func performQuack() {
        quack.quack()
    }
    
    func performFly() {
        fly.fly()
    }
    
    func performSwim() {
        swim.swim()
    }
}


///Creating seperate protocols to each behaviours
protocol Quackable {
    func quack()
}

protocol Swimmable {
    func swim()
}

protocol Flyable {
    func fly()
}


///The concrete classes of ducks
class MallardDuck: Duck {
    var name: String
    var quack: Quackable
    var fly: Flyable
    var swim: Swimmable
    
    init(name: String) {
        self.name = name
        self.quack = Quack()
        self.fly = FlyWithWings()
        self.swim = SwimOnWater()
    }
    
    func display() {
        print("This is a Mallard Duck with the name : \(name)")
    }
}

class RedHeadDuck: Duck {
    var name: String
    var quack: Quackable
    var fly: Flyable
    var swim: Swimmable
    
    init(name: String) {
        self.name = name
        self.quack = Quack()
        self.fly = FlyWithWings()
        self.swim = SwimOnWater()
    }
    
    func display() {
        print("This is a Red Head Duck with the name : \(name)")
    }
}

class RubberDuck: Duck {
    var name: String
    var quack: Quackable
    var fly: Flyable
    var swim: Swimmable
    
    init(name: String) {
        self.name = name
        self.quack = Quack()
        self.fly = FlyWithWings()
        self.swim = SwimOnWater()
    }
    
    func display() {
        print("This is a Rubber Duck with the name : \(name)")
    }
}

class WoodenDuck: Duck {
    var name: String
    var quack: Quackable
    var fly: Flyable
    var swim: Swimmable
    
    init(name: String) {
        self.name = name
        self.quack = Quack()
        self.fly = FlyWithWings()
        self.swim = SwimOnWater()
    }
    
    func display() {
        print("This is a Wodden Duck with the name : \(name)")
    }
}


///The concrete classes of duck behaviours
class Quack: Quackable {
    func quack() {
        print("Quacking loudly.....!")
    }
}

class Squek: Quackable {
    func quack() {
        print("Quacking with medium voice....!")
    }
}

class MuteQuack: Quackable {
    func quack() {
        print("Couldn't quack....!")
    }
}

class SwimOnWater: Swimmable {
    func swim() {
        print("Swimming on water....!")
    }
}

class SwimNoWay: Swimmable {
    func swim() {
        print("Couldn't swim....!")
    }
}

class FlyWithWings: Flyable {
    func fly() {
        print("Flying with wings....!")
    }
}

class FlyNoWay: Flyable {
    func fly() {
        print("Couldn't fly....!")
    }
}

let duckOne: Duck = MallardDuck(name: "Donnald")
duckOne.performFly()
duckOne.performSwim()
duckOne.performQuack()


