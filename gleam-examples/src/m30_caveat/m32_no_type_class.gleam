//
// type class 가 없어서 sum 함수를 Int, Float 별
//

// pub fn sum(numbers: List(a)) -> a {
//   case numbers {
//     [] -> 0
//     [h, ..t] -> h + sum(t)
//   }
// }

//
// Workaround : type variable 과 function 을 사용.
//

pub fn sum(numbers: List(a), init: a, add: fn(a, a) -> a) -> a {
  case numbers {
    [] -> init
    [h, ..t] -> add(h, sum(t, init, add))
  }
}