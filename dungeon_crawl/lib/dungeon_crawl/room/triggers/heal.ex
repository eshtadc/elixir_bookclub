defmodule DungeonCrawl.Room.Triggers.Heal do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, %DungeonCrawl.Room.Action{id: :rest}) do
    Shell.info("You settle down for a little rest.")
    healed_character = DungeonCrawl.Rest.heal(character)

    {healed_character, :forward}
  end
end
