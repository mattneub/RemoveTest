The [problem](https://stackoverflow.com/questions/26173565/removeobjectsatindexes-for-swift-arrays) was to implement
in Swift something comparable to NSMutableArray `removeObjectsAtIndexes:`.

This project time-profiles three possible implementations:

* A naive but obvious reverse-sort followed by repeated `remove(at:)`.
* Swift 4.2 `removeAll(where:)`, which uses half-stable partitioning behind the scenes, with repeated use of `contains`.
* A hand-coded implementation by Vadian using half-stable partitioning and _no_ use of `contains`, because he ingeniously walks
the index set at the same time as he walks the array.

Typical times in my tests (on device, Release build) are:

* 26 seconds
* 0.2 seconds
* 0.02 seconds
