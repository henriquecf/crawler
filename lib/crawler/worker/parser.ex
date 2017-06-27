defmodule Crawler.Worker.Parser do
  alias Crawler.Worker.Fetcher

  @doc """
  ## Examples

      iex> Parser.parse(%CrawlerDB.Page{
      iex>   body: "<a href='http://example.com/'>Example</a>"
      iex> })
      :ok

      iex> Parser.parse(%CrawlerDB.Page{body: "Example"})
      :ok
  """
  def parse(%CrawlerDB.Page{body: body, url: url}) do
    body
    |> Floki.find("a")
    |> Enum.each(&parse_link(&1, url))
  end

  def parse(_), do: nil

  defp parse_link({"a", attrs, _}, looked_url) do
    {"href", url} = Enum.find(attrs, fn {k, _v} -> k == "href" end)
    abs_url = cond do
      String.starts_with?(url, "/") ->
        "#{looked_url}#{url}"
      true ->
        url
    end
    Fetcher.fetch(url: abs_url)
  end
end
