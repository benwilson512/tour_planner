defmodule Base.Serializer do

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      def to_json(model_list) when is_list(model_list) do
        model = hd(model_list).model
        model_list
          |> Enum.map(&model.attributes(&1))
          |> JSON.encode
      end

      def to_json(obj) do
        obj |> obj.model.attributes |> JSON.encode
      end
    end
  end
end
