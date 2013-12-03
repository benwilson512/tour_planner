Dynamo.under_test(TourPlanner.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule TourPlanner.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
