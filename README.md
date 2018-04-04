# App to interact with Reverb.com API

## Installation
1. Install [Elixir](https://elixir-lang.org/) - instructions in the link - if you do not have it. There is an `install_elixir.sh` script for Linux, if you wish.
2. Install [node.js](https://nodejs.org/en/) if you do not have it.
3. Install  and set up [Postgresql](https://www.postgresql.org/) - instructions in the link - if you do not have it. A great simple option for OS X is (http://postgresapp.com/). There is an `install_postgres_ubuntu.sh` install script for *Ubuntu Linux only* if you wish. There is also an `setup_postgres.sh` script, which should work for all Linux distros and for OS X, if you wish.
3. `$ cd reverb_server && mix deps.get`

## To run the server
1. `$ cd reverb_server`
2. `$ mix phx.server` will start the server. Or, `$ iex -S mix phx.server` to run the server inside the IEX repl (recommended for development).
3. Go to `http://localhost:4000` in your browser.
