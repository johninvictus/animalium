# Animalium

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Description

> Animalium.TestAPI

If you provide ID to  `Animalium.TestAPI.get_by_id(id)` it will return a Pokemon name, see doctest.

If you provide Pokemon name to `Animalium.TestAPI.get_by_name(name)` it will return Pokemon ID, see doctest.

For a meaningful output see `Animalium.API.PokemonAPI` it return a map when provided with a ID or name.


### Rest API
To test rest API you can check the following endpoint
1. http://localhost:4000/api/pokemon_by_id?id=14
   ```
   {
    "id": 14,
    "name": "kakuna"
   }
   ```
2. http://localhost:4000/api/pokemon_by_name?name=kakuna
   ```
   {
    "id": 14,
    "name": "kakuna"
   }
   ```

  
### GraphQL API

> Get pokemon by name

```
query {
      pokemonByName(name: "Phoenix"){
        id
        name
      }
    }
```

> Get pokemon by ID

```
query {
        pokemonById(id: 1){
          id
          name
        }
      }
```



