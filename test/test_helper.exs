Dynamo.under_test(TourPlanner2.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule TourPlanner2.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
