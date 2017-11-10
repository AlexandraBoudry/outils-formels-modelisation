import PetriKit

public extension PTNet {

    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.


        let transitions = self.transitions
        let initNode = CoverabilityGraph(marking: marking)
        var toVisit = [CoverabilityGraph]()
        var seen = [CoverabilityGraph]()

        toVisit.append(initNode)

        while toVisit.count != 0 {
          let current = toVisit.removeFirst()
          seen.append(current)
          transitions.forEach { trans in
            if var newMark = trans.fire(from: current.marking) {
              newMark = verifOmega(mark : newMark, list : seen)
              if let alreadySeen = seen.first(where: { $0.marking == newMark }) {
                current.successors[trans] = alreadySeen
              }
              else {
                let discovered = CoverabilityGraph(marking: newMark)
                current.successors[trans] = discovered
                if (!toVisit.contains(where: { $0.marking == discovered.marking})) {
                  toVisit.append(discovered)
                }
              }
            }
          }
        }
        return initNode
      }

      // vérifie si le marquage est plus grand qu'un précédent et set omega si c'est la cas
      private func verifOmega(mark : CoverabilityMarking, list : [CoverabilityGraph]) -> CoverabilityMarking {
        var ret = mark
        for pastNode in list {
          if ret > pastNode.marking{
            for place in ret.keys {
              if ret[place]! > pastNode.marking[place]! {
                ret[place] = .omega
              }
            }
            return ret
          }
        }
        return mark
      }
    }

    // implémenttation de isFireable et fire avec CoverabilityMarking
    public extension PTTransition {

      public func isFireable(from marking: CoverabilityMarking) -> Bool {
        for arc in self.preconditions {
          if case .some(let nb) = marking[arc.place]! {
            if nb < arc.tokens{
              return false
            }
          }
        }
        return true
      }

      public func fire(from marking: CoverabilityMarking) -> CoverabilityMarking? {
        guard self.isFireable(from: marking) else {
          return nil
        }
        var res = marking

        for arc in self.preconditions {
          if case .some(let nb) = res[arc.place]! {
            res[arc.place]! = .some(nb - arc.tokens)
          }
        }
        for arc in self.postconditions {
          if case .some(let nb) = res[arc.place]! {
            res[arc.place]! = .some(nb + arc.tokens)
          }
        }
        return res

      }

}
