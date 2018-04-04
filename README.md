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

## To run tests
1. `$ cd reverb-server`
2. `$ mix test`
3. To run an individual test suite, `$ mix test test/reverb_server/the_name_of_my_test_here.exs` (Note the `.exs` extension), or `$mix test test/reverb_server_web/the_name_of_my_test_here.exs`
## To experiment with the app
1. `$ cd reverb_server`
2. `$ iex -S mix phx.server`. This will open up an REPL which allows you to interact with the running application. **Perform all of the following commands in this REPL**. These commands are function calls on modules in the application.
3. `> alias ReverbServer, as: S`
4. `> S.ReverbAPI.get_listings_all` -- hits the `/listings/all` endpoint. 
5. `> S.ReverbAPI.get_listings_all({per_page: 10})` to return ten results per page. You may pass in any other params which this endpoint accepts. **NOTE: Strings must be double-quoted**
6. `> S.ReverbAPI.get_categories_flat` -- hits the `/categories/flat` endpoint.
7. `> S.ReverbAPIHelpers.get_categories_with_string("bassoon")` filters the results of the above endpoint by the given string. 
8. **Any** module function (except for private functions, defined with `defp` (including third-party modules such as the [Poison JSON Encoder](https://github.com/devinus/poison) will work in here!

Some areas of interest (all of which can be explored in the REPL) are: 

- [reverb_server/lib/reverb_server/http_client.ex](https://github.com/adamcee/reverb_app/blob/master/reverb_server/lib/reverb_server/http_client.ex), the HTTP client which is used by [reverb_server/lib/reverb/server/http_client_helpers.ex](https://github.com/adamcee/reverb_app/blob/master/reverb_server/lib/reverb_server/http_client_helpers.ex)

- The `HTTPClientHelpers` module is used by the `ReverbAPI` module, located at [reverb_server/lib/reverb_server/reverb_api.ex](https://github.com/adamcee/reverb_app/blob/master/reverb_server/lib/reverb_server/reverb_api.ex). This is then used by the [ReverbAPIHelpers](https://github.com/adamcee/reverb_app/blob/master/reverb_server/lib/reverb_server/reverb_api_helpers.ex) to do things like filter the results of `/categories/flat`. 

- [The type files at /reverb_server/lib/reverb_server/types](https://github.com/adamcee/reverb_app/tree/master/reverb_server/lib/reverb_server/types) which are used to parse and validate response JSON from the Reverb API. In conjunction with the `get_json_file` function in the [Utils module](https://github.com/adamcee/reverb_app/blob/master/reverb_server/lib/reverb_server/utils.ex), and the mock data in `reverb_server/mock_data`. In the REPL you can transform HTTP response JSON (or the mock response JSON) into various types and then explore them.
