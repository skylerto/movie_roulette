![alt text](https://raw.githubusercontent.com/skylerto/movie_roulette/master/img/roulette_wheel_50.png)

# Movie Roulette

[![Build Status](https://travis-ci.org/skylerto/movie_roulette.svg?branch=master)](https://travis-ci.org/skylerto/movie_roulette)

Movie roulette is a [Google Actions](https://developers.google.com/actions/)
Application.

The goal is to help you determine which movie to watch when you have absolutely
no idea what you want to watch.

## Usage

Sample dialog:

Init: Talk to Movie Roulette
Home: What genre would you like?
You: action
Home: How about Big Hero 6?
You: You me more
Home: I can tell you about ... What would you like to know?
You: overview
Home: ... how does that sound?

### Environment Variables

To use, you will need to set an environment variable to access The MovieDB API,
you can find more information about getting an API key [here](https://developers.themoviedb.org/3/getting-started/introduction).

```
export MOVIEDB_API_KEY=<your api key>
```
