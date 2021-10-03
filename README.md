# User Manager

# About this project

This is a project to build a simple manager of users, allowing the admin's users to control the another users also import them of a spreadsheet file.

# Used Technologies

## Backend
- Ruby 
- Rails 
- Postgresql 
- Docker

## Frontend

- Html 
- Css 
- Bootsrap 

# Requirements
- Docker and docker-compose
- Ruby on Rails 6.1.4

## Backend

### dependencies
-  cable_ready 
-  cancancan 
-  devise
-  Rspec
-  factory_bot_rails
-  faker
-  roo
-  shoulda-matchers 

## Frontend

### dependencies

- Bootstrap 
- Popperjs
- cable_ready 

# How to execute this project


```bash
# clone repository
git clone https://github.com/isaacbrds/user_manager.git 

# access the folder
cd user_manager

# Build a docker project
docker-compose build

# Install gems

docker-compose run --rm app bundle 

# Create a database
docker-compose run --rm app bundle exec rails db:create db:migrate 

# Install JS libs
docker-compose run --rm app yarn

# Create a database
docker-compose run --rm app bundle exec rails db:seed

# Run dockerized project

docker-compose up

# Access with admin's

user: admin@mail.com
password: 123456

```

# How to test this project

```bash 

# Run rspec 

docker-compose run --rm app bundle exec rspec

```
# Autor

Isaac Brígido Rodrigues dos Santos
