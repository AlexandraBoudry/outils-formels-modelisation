import PetriKit
import PhilosophersLib

do {
    enum C: CustomStringConvertible {
        case b, v, o

        var description: String {
            switch self {
            case .b: return "b"
            case .v: return "v"
            case .o: return "o"
            }
        }
    }

    func g(binding: PredicateTransition<C>.Binding) -> C {
        switch binding["x"]! {
        case .b: return .v
        case .v: return .b
        case .o: return .o
        }
    }

    let t1 = PredicateTransition<C>(
        preconditions: [
            PredicateArc(place: "p1", label: [.variable("x")]),
        ],
        postconditions: [
            PredicateArc(place: "p2", label: [.function(g)]),
        ])

    let m0: PredicateNet<C>.MarkingType = ["p1": [.b, .b, .v, .v, .b, .o], "p2": []]
    guard let m1 = t1.fire(from: m0, with: ["x": .b]) else {
        fatalError("Failed to fire.")
    }
    print(m1)
    guard let m2 = t1.fire(from: m1, with: ["x": .v]) else {
        fatalError("Failed to fire.")
    }
    print(m2)
}

print()

do {
    let philosophers = lockFreePhilosophers(n: 3)
    // let philosophers = lockablePhilosophers(n: 3)
    for m in philosophers.simulation(from: philosophers.initialMarking!).prefix(10) {
        print(m)
    }
}

/*  Séance exercice du 17.11.2017
do{
  //dom(Ingredients)= (p, t, m)
  enum Ingredients {
  case p, t, m
  }
  //dom(Smokers) = (mia, bob, tom)
  enum Smokers{
  case mia, bob, tom
  }
  //dom(Referee) = (rob)
  enum Referee{
    case rob
  }
  //Types = {Ingredients, Smokers, Referee}
  enum Types{
  case ingredients(Ingredients)
  case smokers(Smokers)
  case referee(Referee)
  }

  let s = PredicateTransition<Types>(
    preconditions: [
      PredicateArc(place: "i", label: [.variable("x"), .variable("y")]),
      PredicateArc(place: "s", label: [.variable("s")]),
    ],
    postconditions: [
      PredicateArc(place: "r", label: [.function({_in.referee(.rob)})]),
      PredicateArc(place: "w", label:[.variable("s")]),
    ],
    conditions: [{binding in
      guard case let .smokers(s) = binding["s"]!,
            case let .ingredients(x) = binding["x"]!,
            case let .ingredients(y) = binding["y"]!
      else{
        return false
      }

      switch (s, x, y) {
      case (.mia, .p, .t):return true
      case (.tom, .p, .m): return true
      case (.bob, .t, .m): return true
      default:             return false
      }
    }]))
}
*/


// 1- Combien y a-t-il de marquages possibles dans le modèle des philosophes non-bloquable à 5 philosophes?
do {
        let philosophers = lockFreePhilosophers(n: 5)
        let philoMark = philosophers.markingGraph(from: philosophers.initialMarking!)
        print("Il existe \(philoMark!.count) marquages possibles dans le modèle des philosophes non-bloquable à 5 philosophes.\n")
}

// 2- Combien y a-t-il de marquages possibles dans le modèle des philosophes bloquable à 5 philosophes?
do {
        let philosophers = lockablePhilosophers(n: 5)
        let philoMark = philosophers.markingGraph(from: philosophers.initialMarking!)
        print("Il existe \(philoMark!.count) marquages possibles dans le modèle des philosophes bloquable à 5 philosophes.\n")
}

// 3- Donnez un exemple d’état où le réseau est bloqué dans le modèle des philosophes bloquable à 5 philosophes?
do {
        let philosophers = lockablePhilosophers(n: 5)
        let philoMark = philosophers.markingGraph(from: philosophers.initialMarking!)

         for m in philoMark! {
           var blocked = true
           for (_, s) in m.successors {
                        if(s.count != 0) { blocked = false}
            }
           if (blocked){
             print("Le réseau est bloqué à l'état \(m.marking)");
             break
           }

         }
}
