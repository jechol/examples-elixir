## Confusing string


|        | Elixir    | Erlang         | Gleam          |
| ------ | --------- | -------------- | -------------- |
| "abc"  | string    | char list      | string         |
| 'abc'  | char list | atom           | syntax error   |
| binary | "abc"     | <<"abc"/utf8>> | <<"abc":utf8>> |