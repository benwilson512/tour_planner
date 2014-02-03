defmodule ApiV1ResourcesRouter do
  use Dynamo.Router
  import Ecto.Query

  get "/" do
    Resource.all
      |> Resource.to_json
      |> conn.resp_body
  end

  post "/" do
    conn = conn.fetch :body
    {:ok, ids} = conn.req_body |> JSON.decode

    from(r in Resource, where: r.id in ^ids)
      |> Repo.all
      |> Enum.map(&(&1.on_device(true)))
      |> Enum.map(&(Repo.update(&1)))

    conn.status(200)
  end

end
