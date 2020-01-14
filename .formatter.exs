# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    let: 1,
    tell: 1,
    get: 1,
    put: 1,
    modify: 1,
    return: 1,
    defdata: 1,
    defdata: 3,
    defsum: 1,
    defalias: 2
  ]
]
