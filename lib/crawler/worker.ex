defmodule Crawler.Worker do
  use GenServer
  require Logger

  alias Crawler.Worker.{Fetcher, Parser}

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def handle_cast(_req, state) do
    state
    |> Fetcher.fetch()
    |> Parser.parse()

    Logger.info("Crawling para #{state[:url]} finalizado com sucesso")

    {:noreply, state}
  end

  def cast(pid, term \\ []) do
    GenServer.cast(pid, term)
  end
end
