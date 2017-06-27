sites = ["http://elixir-lang.org", "http://google.com.br", "http://phoenixframework.org"]

Enum.each(sites, fn s -> Crawler.crawl(s) end)
