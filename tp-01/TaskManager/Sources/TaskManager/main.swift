import TaskManagerLib

let taskManager = createTaskManager()

// Show here an example of sequence that leads to the described problem.
// For instance:
//     let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
//     let m2 = spawn.fire(from: m1!)
//     ...
let create = taskManager.transitions.filter{$0.name=="create"}[0]
let spawn = taskManager.transitions.filter{$0.name=="spawn"}[0]
let exec = taskManager.transitions.filter{$0.name=="exec"}[0]
let sucess = taskManager.transitions.filter{$0.name=="success"}[0]
let fail = taskManager.transitions.filter{$0.name=="fail"}[0]

let taskPool = taskManager.places.filter{$0.name=="taskPool"}[0]
let processPool = taskManager.places.filter{$0.name=="processPool"}[0]
let inProgress = taskManager.places.filter{$0.name=="inProgress"}[0]


let m1 = create.fire(from:[taskPool: 0, processPool: 0, inProgress: 0])
print(m1)
let m2 = spawn.fire(from: m1!)
print(m2)
let m3 = spawn.fire(from: m2!)
print(m3)
let m4 = exec.fire(from: m3!)
print(m4)
let m5 = sucess.fire(from: m4!)
print(m5)
let m6 = exec.fire(from: m5!)
print(m6)



let correctTaskManager = createCorrectTaskManager()

// Show here that you corrected the problem.
// For instance:
//     let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
//     let m2 = spawn.fire(from: m1!)
//     ...
let create2 = correctTaskManager.transitions.filter{$0.name=="create"}[0]
let spawn2 = correctTaskManager.transitions.filter{$0.name=="spawn"}[0]
let exec2 = correctTaskManager.transitions.filter{$0.name=="exec"}[0]
let sucess2 = correctTaskManager.transitions.filter{$0.name=="success"}[0]
let fail2 = correctTaskManager.transitions.filter{$0.name=="fail"}[0]

let taskPool2 = correctTaskManager.places.filter{$0.name=="taskPool"}[0]
let processPool2 = correctTaskManager.places.filter{$0.name=="processPool"}[0]
let inProgress2 = correctTaskManager.places.filter{$0.name=="inProgress"}[0]
let newPlace2 = correctTaskManager.places.filter{$0.name=="newPlace"}[0]


let m21 = create2.fire(from:[taskPool2: 0, processPool2: 0, inProgress2: 0, newPlace2: 0])
print(m21)
let m22 = spawn2.fire(from: m21!)
print(m22)
let m23 = spawn2.fire(from: m22!)
print(m23)
let m24 = exec2.fire(from: m23!)
print(m24)
let m25 = sucess2.fire(from: m24!)
print(m25)
let m26 = exec2.fire(from: m25!)
print(m26)
