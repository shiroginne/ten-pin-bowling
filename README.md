### About

It's a simple 10 pins bowling game backend. Created to find out new Rails feature and ideas.

### Install

`git clone`
`bundle install`
`rails s`

### Usage

#### Create a game
To create a game you need to send a hash with params to the endpoint

`POST /games`

```
{
  game: {
    name: "game name",
    players_attributes: [
      { name: "player game" }
    ]
  }
}
```

Mandatory fields:
- `game: { :name }`
- `players_attributes: [ :name ]`


for example:
> curl -H "Content-Type: application/json" -X POST -d '{"game": { "title": "Game of Thrones", "players_attributes": [{"name": "John"}] } }' localhost:3000/games

#### Get game information
To get a game information you need to send a request to the endpoint
`GET /games/1`

for example:
> curl -H "Content-Type: application/json" -X GET localhost:3000/games/1


#### Make a turn
To make your turn, send a hash with params to endpoint

`POST games/1/turns`

```
  {
    turn: {
      game_id: game_id,
      frame_id: frame_id,
      player_id: player_id,
      pins_count: 1-10
    }
  }
```

Mandatory fields:
- `game_id`
- `frame_id`
- `player_id`
- `pins_count`


for example:
> curl -H "Content-Type: application/json" -X POST -d '{"game_id": 1, "frame_id": 1, "player_id":1, "pins_count": 8 }' localhost:3000/games/1/turns

### TODO

- [ ] make more friendly error messages
- [ ] apply [JSON API](https://jsonapi.org/)
- [ ] use [swagger](https://github.com/richhollis/swagger-docs) for documentation
