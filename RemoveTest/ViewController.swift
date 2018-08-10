


import UIKit

extension Array {
    mutating func remove (at ixs:[Int]) -> () {
        for i in ixs.sorted(by: >) {
            self.remove(at:i)
        }
    }
}

extension Array {
    mutating func remove(at set:IndexSet) {
        var arr = Swift.Array(self.enumerated())
        arr.removeAll{set.contains($0.offset)}
        self = arr.map{$0.element}
    }
}

extension Array { // https://pastebin.com/HLEVUvY8 by Vadian
    mutating func remove2(at indexes : IndexSet) {
        guard var i = indexes.first, i < count else { return }
        var j = index(after: i)
        var k = indexes.integerGreaterThan(i) ?? endIndex
        while j != endIndex {
            if k != j { swapAt(i, j); formIndex(after: &i) }
            else { k = indexes.integerGreaterThan(k) ?? endIndex }
            formIndex(after: &j)
        }
        removeSubrange(i...)
    }
}



class ViewController: UIViewController {
    
    var arr = [Int]()
    var ixs = [Int]()
    var set = IndexSet()

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let lim = 100000
        self.arr = Array(0...lim)
        //
        let ixlim = lim-1
        let ixs = sequence(first: 1, next: { i in
            return i >= ixlim ? nil : i+2
        })
        self.ixs = Array(ixs)
        self.set = IndexSet(ixs)
        //
        var arr1 = self.arr
        var arr2 = self.arr
        arr1.remove(at:self.ixs)
        arr2.remove(at:self.set)
        precondition(arr1 == arr2, "The algorithms don't get the same answer")
        print("The algorithms get the same answer")
        //
        arr1 = self.arr
        arr2 = self.arr
        arr1.remove(at:self.ixs)
        arr2.remove2(at:self.set)
        precondition(arr1 == arr2, "The algorithms don't get the same answer")
        print("The algorithms get the same answer")
    }
    
    @IBAction func doButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            print("start")
            let lim = 20
            var total1 = 0.0
            var total2 = 0.0
            var total3 = 0.0
            for _ in 0..<lim {
                var d1 = Date()
                
                var arr = self.arr
                d1 = Date()
                self.alg1(&arr)
                total1 += Date().timeIntervalSince(d1)
                
                arr = self.arr
                d1 = Date()
                self.alg2(&arr)
                total2 += Date().timeIntervalSince(d1)

                arr = self.arr
                d1 = Date()
                self.alg3(&arr)
                total3 += Date().timeIntervalSince(d1)

            }
            print("finish")
            print(total1)
            print(total2)
            print(total3)
        }
    }
    func alg1(_ arr1 : inout [Int]) {
        arr1.remove(at:self.ixs)
    }
    func alg2(_ arr2 : inout [Int]) {
        arr2.remove(at:self.set)
    }
    func alg3(_ arr3 : inout [Int]) {
        arr3.remove2(at:self.set)
    }



}

