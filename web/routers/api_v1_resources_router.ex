defmodule ApiV1ResourcesRouter do
  use Dynamo.Router
  import Ecto.Query

  get "/" do
    Resource.all
      |> Resource.to_json
      |> conn.resp_body
  end

end
