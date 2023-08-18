# PoC - Kong plugins written in Go

This a PoC for a plugin written in Go for Kong.

It will read a config and add a header to your request.

## Requirements

- Docker
- Docker compose
- Deck

## Running

1. Run the following command in your terminal: `$ docker compose up`
2. At a new tab, sync deck: `$ deck sync --kong-addr http://0.0.0.0:8001 -s ./routes.yaml --verbose 2`
3. Call your API and check the headers of the response: `$ curl -v --location 'http://0.0.0.0:8000/test'`
