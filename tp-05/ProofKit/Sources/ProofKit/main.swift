import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let f = a && b

print(f)

//exercice 2, Transformations, séance 9, 24.11.2017
let f1 = !(a && (b || c))
print("ex1:")
print("formule: \(f1)")
print("nnf    : \(f1.nnf)")
print("cnf    : \((!a || !b) && (!a || !c))")
print("dnf    : \(f1.nnf)")

let f2 = (a => b) || !(a && c)
print("ex2:")
print("formule: \(f2)")
print("nnf    : \(f2.nnf)")
print("cnf    : \((!a || b || !c))")
print("dnf    : \((!a || b || !c))")

let f3 = (!a || b && c) && a
print("ex3:")
print("formule: \(f3)")
print("nnf    : \(f3.nnf)")
print("cnf    : \(b && c && a)")
print("dnf    : \(b && c && a)")
//fin ex2



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
