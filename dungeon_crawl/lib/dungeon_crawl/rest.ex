defmodule DungeonCrawl.Rest do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  # can rest up to three times
  # rest_and_heal(character, count)
  def rest(character), do: rest_and_heal(character, 3)

  defp rest_and_heal(character, 0) do
    # This is your last rest so you must go back
    Shell.info("You have overstayed your welcome. It's time to continue")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")
    character
  end
  defp rest_and_heal(%{hit_points, max_hit_points}, _)
    when current_hit_points = max_hit_points do
      #You are all healed
      Shell.info("You have overstayed your welcome. It's time to continue")
      Shell.prompt("Press Enter to continue")
      Shell.cmd("clear")
      character
    end

  defp rest_and_heal(character, remaining) do
    # You heal a random amount
    healed_character = heal(character, 1) # maybe make this random?

    healed_character
    |> heal_message
    |> Shell.info

    # Do you want to stay or return
    if Shell.yes?(confirm_stay), do: rest_and_heal(healed_character, remaining - 1), else: healed_character
  end

  defp heal_message(character) do
    "Rest has been kind to you.\n#{current_stats(character)}"
  end

  defp confirm_stay(character) do
    "Do you want to rest more?"
  end
end
