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

## To use the app
1. `$ cd reverb_server`
2. `$ iex -S mix phx.server`. This will open up an REPL which allows you to interact with the running application. *Perform all of the following commands in this REPL*. These commands are function calls on modules in the application.
3. `> alias ReverbServer, as: S`
4. `> S.ReverbAPI.get_listings_all` -- hits the `/listings/all` endpoint. 
5. `> S.ReverbAPI.get_listings_all({per_page: 10})` to return ten results per page.
6. `> S.ReverbAPI.get_categories_flat` -- hits the `/categories/flat` endpoint.
7. `> S.ReverbAPIHelper.get_categories_with_string("bassoon")` filters the results of the above endpoint by the given string. 
