defmodule Base.Serializer do

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      def to_json(model_list) when is_list(model_list) do
        if length([]) > 0 do
          model = hd(model_list).model
          {:ok, json} = model_list
            |> Enum.map(&model.attributes(&1))
            |> JSON.encode
          json
        else
          "[]"
        end
      end

      def to_json(obj) do
        {:ok, json} = obj |> obj.model.attributes |> JSON.encode
        json
      end
    end
  end
end
