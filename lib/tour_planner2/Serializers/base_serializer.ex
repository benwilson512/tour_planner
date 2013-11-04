defmodule Base.Serializer do

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      def to_json(model_list) when is_list(model_list) do
        model = hd(model_list).model
        model_list
          |> Enum.map(&model.attributes(&1))
          |> Enum.map(&json_safe(&1))
          |> Jsonex.encode
      end

      def to_json(obj) do
        obj |> obj.model.attributes |> json_safe |> Jsonex.encode
      end
    end
  end


  def json_safe(attrs) do
    attrs |> Enum.map(fn {key, value} ->
      if value do
        {key, value}
      else
        {key, ""}
      end
    end)
  end
end
