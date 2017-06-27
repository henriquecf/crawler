defmodule Crawler.Worker.Fetcher do
  require Logger

  @fetch_opts [
    follow_redirect: true,
    max_redirect:    5
  ]

  def fetch(opts) do
    url = opts[:url]

    case HTTPoison.get(url, [], @fetch_opts) do
      {:ok, %{status_code: 200, body: body}} ->
        Logger.debug("URL #{url} armazenada com sucesso")
        store_fetched_page(url, body)
      _ ->
        Logger.warn("URL #{url} não pode ser armazenada.")
        false
    end
  end

  defp store_fetched_page(url, body) do
    CrawlerDB.Page.add(url, body)
  end
end
