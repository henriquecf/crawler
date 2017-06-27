use Amnesia

defdatabase CrawlerDB do
  deftable Page, [:url, :body], type: :bag do
    @type t :: %Page{url: String.t, body: String.t}

    def add(url, body) do
      %Page{url: url, body: body} |> Page.write!()
    end

    def find(url) do
      Page.read!(url) |> Enum.at(0)
    end

    def all() do
      :ets.tab2list(CrawlerDB.Page)
      |> Enum.map(fn {_, url, body} -> %Page{url: url, body: body} end)
    end
  end
end
