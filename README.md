# TourPlanner

1. Install Elixir:

        brew install elixir --head

2. Clone this repository
3. Install dependencies (think bundler)
   After 'cd'ing into the directory:

        mix deps.get

  It may ask you something, say yes.

4. Run server:

        iex -S mix server

5. Browse to:

        http://localhost:4000

Assets are in

    priv/assets

Currently all CSS is in application.css
Layout is application.html.eex

Routes show is web/templates/routes/show.html.eex

