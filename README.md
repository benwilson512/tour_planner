# TourPlanner

1. Install Elixir:

        brew install elixir --head

2. Clone this repository
3. Install dependencies (think bundler)
   After 'cd'ing into the directory:

        mix deps.get

  It may ask you something, say yes.

4. Setup database:
      
        mix do compile, db.setup

  If this fails it's most likely because the port to your postgres service isn't correct. Contact me in this case.

5. Run server:

        iex -S mix server

6. Load seed data. Enter the following into the REPL that the previous command created. You should see a fair bit of output.

        Repo.Seeds.run

7. Browse to:

        http://localhost:4000/routes

Assets are in

    priv/assets

Currently all CSS is in application.css
Layout is application.html.eex

Routes show is web/templates/routes/show.html.eex

