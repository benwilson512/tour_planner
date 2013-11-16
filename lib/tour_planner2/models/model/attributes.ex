defmodule Model.Attributes do

  defmacro __using__(_opts) do
    quote do

      def attributes(obj) do
        fields |> Enum.map(&{&1, apply(__MODULE__.Entity, &1, [obj])})
      end

      def fields do
        __MODULE__.Entity.__entity__(:field_names)
      end
      
    end
  end
end
