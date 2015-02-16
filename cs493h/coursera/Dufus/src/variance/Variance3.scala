package variance

// contravariance

trait OutputChannel[-T] {
  def write (x : T)
}

// LISKOV SUBSTITUTION PRINCIPAL

// It's safe to assume type T is a subtype of type U 
// IF you can substitute a value of T whenever a value of U is required

// both at once !

trait Function1 [-S, +T] {
  def apply(x : S) : T
}