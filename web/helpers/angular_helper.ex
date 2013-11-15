defmodule AngularHelper do

  def embed_data(name, json) do
    "<script type='text/javascript' id='embed_data_#{name}'>#{json}</script>"
  end

end
