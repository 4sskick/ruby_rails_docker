# Rails App

Welcome to your [Ruby On Rails](https://rubyonrails.org/) app.

## Setup & Running Locally

Clone down the repo, install [Docker](https://hub.docker.com/editions/community/docker-ce-desktop-mac/) & run:

```bash
$ docker-compose build
# $ docker-compose run --rm web rails new <project_name> --database=<postgresql_or_else> --api
```

run project after project generated

### Generate Project

going inside the container using `--service-ports`. That flag will automatically expose ports specified in the service's `ports` section to the host machine when using `rails s -p 3000 -b 0.0.0.0`

```bash
$ docker-compose run --service-ports web bash
$ rails new <project_name> --api
```

generated project file will available directly on local machine also, project ready to run

```bash
$ rails server -p 3000 -b 0.0.0.0
```

# open web browser and type `localhost:3000`

=============================================

### Database Initialize

```bash
$ docker-compose run --rm web sh -c "cd <project_path_folder> && rake db:create"
```

or simply direct to <project_path_folder> then \*but seem like not working

```bash
$ cd <project_path_folder>
$ docker-compose run --rm web rake db:create
```

## Next(?)

- make sure the generated RoR are running well
- update script to run server
- script to integrate with Heroku as deployment

## Contributing

This project still on early setup and have many bug, if you have any idea please make a PR! :)

## Usage

Feel free to use these as a starting point for your own Ruby on Rails project!

## Resources

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Ruby on Rails API Documentation](https://api.rubyonrails.org/)

## License

[MIT](https://opensource.org/licenses/MIT)

Copyright (c) 2022-present, wit love [niteroomcreation](https://github.com/4sskick/)
