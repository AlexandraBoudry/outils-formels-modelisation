import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let d: Formula = "d"

let f = a && b

//session ex 01.12.2017

let j = (a || b) |- (a && c) || (b && c) || !c
print("ex1.2")
print(j.isProvable)

let k = (a => b) && (a => c) && (b => d) && (c => d) |- a => d
print("ex1.3")
print(k.isProvable)

let l = (a => b) && (b => a) |- (a => b)&&(b => a)
print("ex1.4")
print(l.isProvable)

do{

  let f1: Formula = "Il fait beau"
  let f2: Formula = "On va à l'université" // == être
  let f3: Formula = "Il risque de pleuvoir"
  let f4: Formula = "On reste à la maison"
  let f5: Formula = "On fait des exercices"
  let f6: Formula = "on relit le cours"
  let f7: Formula = "On est content"
  let f8: Formula = "Le ciel est gris"

  let j = ((f1 => f2) && (f3 => !f2) && (!f4 => f2) && (f4 => (f5 && f6)) && (f8 => f3) && (f2 => (f5 && f7)) && (f1 || f8)) |- f5

  print("ex2")
  print(j.isProvable)

}


print(f)

let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
