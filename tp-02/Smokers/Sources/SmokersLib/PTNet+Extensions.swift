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


        let m0:MarkingGraph = MarkingGraph(marking: marking)
        var seenNode : [MarkingGraph] = [m0]
        var toVisit : [MarkingGraph] = [m0]

        while let current = toVisit.popLast(){
          seenNode.append(current)
          for tr in transitions {
            if let firedTr = tr.fire(from: current.marking){
              if let seen = seenNode.first(where: {$0.marking == firedTr}){
                current.successors[tr] = seen
              }
              else{
                let successor:MarkingGraph = MarkingGraph(marking: firedTr)
                if !seenNode.contains{$0 === successor}{
                current.successors[tr] = successor
                  toVisit.append(successor)
                }
              }
            }
          }
        }
      print("\(seenNode)")
      return m0
  }

}
