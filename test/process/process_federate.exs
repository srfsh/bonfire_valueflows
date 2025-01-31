defmodule ValueFlows.Process.FederateTest do
  use Bonfire.ValueFlows.DataCase

  import Bonfire.Common.Simulation
  import Bonfire.Geolocate.Simulate
  import ValueFlows.Simulate
  import ValueFlows.Test.Faking

  @debug false
  @schema Bonfire.GraphQL.Schema

  describe "process" do
    test "federates/publishes" do
      user = fake_agent!()

      process = fake_process!(user)

      #IO.inspect(pre_fed: proposal)

      assert {:ok, activity} = Bonfire.Federate.ActivityPub.Publisher.publish("create", process)
      #IO.inspect(published: activity) ########

      assert activity.pointer_id == process.id
      assert activity.local == true

      assert activity.data["object"]["name"] == process.name
    end
  end
end
