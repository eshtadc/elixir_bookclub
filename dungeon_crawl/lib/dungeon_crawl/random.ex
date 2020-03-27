defmodule DungeonCrawl.Random do
  def weighted(items) do
    compare_value = get_random_comparison(items)

    items
    |> select_random_item(compare_value)
  end

  defp select_random_item([%{weight: room_weight}=room | _tail], random_compare) when random_compare < room_weight, do: room
  defp select_random_item([room | tail], random_compare), do: select_random_item(tail, random_compare - room.weight)

  defp get_random_comparison(items) do
    items
    |> Enum.map(&(&1.weight))
    |> Enum.sum()
    |> get_random_weight
  end

  defp get_random_weight(maximum), do: Enum.random(1..maximum)
end
