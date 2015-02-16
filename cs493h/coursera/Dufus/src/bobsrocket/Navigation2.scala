package bobsrocket2 {
  class Ship
}

package bobsrockets2.fleets {
  import bobsrocket2._
  class Fleet {
    // Doesn’t compile! Ship is not in scope.
    def addShip() { new Ship }
  }
}