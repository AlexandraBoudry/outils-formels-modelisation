import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]


    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors

    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.


        let transitions = self.transitions
        let initialNode = MarkingGraph(marking: marking)
        var seenNode = [MarkingGraph]()
        var toVisit = [MarkingGraph] ()

        toVisit.append(initialNode)

        while toVisit.count != 0 {
            let current = toVisit.removeFirst()
            seenNode.append(current)
            transitions.forEach { tr in
              if let newM = tr.fire(from: current.marking) {
                        if let visited = seenNode.first(where: { $0.marking == newM }) {
                            current.successors[tr] = visited
                        } else {
                            let foundedNode = MarkingGraph(marking: newM)
                            current.successors[tr] = foundedNode
                            if (!toVisit.contains(where: { $0.marking == foundedNode.marking})) {
                                toVisit.append(foundedNode)
                            }
                    }
                }
            }
        }

        return initialNode
    }



    // Retourne le nombre de noeuds dans un graphe de marquage donné

    public func count (mark: MarkingGraph) -> Int{
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()
      var unique = [MarkingGraph]()

      toSee.append(mark)
      while let current = toSee.popLast() {
        seen.append(current)
        for(_, successor) in current.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      for state in seen {
          if(!unique.contains(where :{$0.marking == state.marking})){
            unique.append(state)
          }
      }
      return unique.count
    }

    // Retourne true s'il existe un noeud où au moins 2 fumeurs fument en même temps

    public func twoSmokers (mark: MarkingGraph) -> Bool {
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()

      toSee.append(mark)
      while let current = toSee.popLast() {
        seen.append(current)
        var nbSmoker = 0;
        for (key, value) in current.marking {
            if (key.name == "s1" || key.name == "s2" || key.name == "s3"){
               nbSmoker += Int(value)
            }
        }
        if (nbSmoker > 1) {
          return true
        }
        for(_, successor) in current.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      return false
    }

    // Retourne true s'il existe un noeud où il y a plus qu'une fois le
    // même ingrédient sur la table

    public func moreThanOneIng (mark: MarkingGraph) -> Bool {
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()

      toSee.append(mark)
      while let current = toSee.popLast() {
        seen.append(current)
        for (key, value) in current.marking {
            if (key.name == "p" || key.name == "t" || key.name == "m"){
               if(value > 1){
                 return true
               }
            }
        }
        for(_, successor) in current.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      return false
    }

}
