typealias PTMarking = String

class MarkingGraph: CustomStringConvertible {
let marking: PTMarking
var successors: [PTTransition: MarkingGraph] // en ajoutant PTTransition, on ajoute un dictionnaire qui permet d'avoir les transitions

init (marking: PTMarking , successors: [MarkingGraph]) {
  self.marking = marking
  self.successors = successors
  }

  var description: String {
    return String(describing:self.marking)
  }
}

var m0 =MarkingGraph(markin:["p1", "p2", "p3", "f1", "f2", "f3"], sucessors: []) //mettre le nom et le nombre de jeton
var m1 =MarkingGraph(markin:["p1", "p2", "q3", "f2"], sucessors: [m0])
var m2 =MarkingGraph(markin:["p1", "q2", "p3", "f1"], sucessors: [m0])
var m3 =MarkingGraph(markin:["q1", "p2", "p3", "f3"], sucessors: [m0])

//en faisant comme ça, j'ai pas l'information des transitions, juste les sucesseurs

m0.sucessors=[t3: m1, t2:m2, t1: m3]
