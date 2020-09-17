
// 
// Cannot guarantee if pattern matching covers every cases.
//

pub fn count(list: List(a)) -> Int {
  case list {
    // [] is missing here, but compiler doesn't warn.
    [_] -> 1
    [_h, ..t] -> 1 + count(t)
  }
}
