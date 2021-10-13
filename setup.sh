docker-compose build

# Compile deps and initialize database for backend
docker-compose run backend mix do deps.get, deps.compile, ecto.setup
# Install npm packages
docker-compose run backend yarn --cwd assets

# Compile deps and initialize database for backend
docker-compose run frontend mix do deps.get, deps.compile, ecto.setup
# Install npm packages
docker-compose run frontend yarn --cwd assets
