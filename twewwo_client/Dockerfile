FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app
RUN apk add yarn inotify-tools

COPY mix.exs .
COPY mix.lock .

RUN mkdir assets

COPY assets/package.json assets
COPY assets/yarn.lock assets

RUN mix do deps.get, deps.compile && yarn --cwd assets
