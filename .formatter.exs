[
  inputs: ["*.exs", "config/*.exs"],
  subdirectories: ["apps/*"],
  locals_without_parens: [
    return: 1,
    monad: 2,
    chain: 1,
    reather: 2
  ]
]
