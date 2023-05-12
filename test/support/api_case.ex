defmodule Tychron.Support.APICase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Tychron.Support.APICase
      import Tychron.Support.PlugPipelineHelpers
    end
  end

  setup tags do
    bypass = open_api_bypass()

    {:ok, Map.put(tags, :bypass, bypass)}
  end

  def make_page_result(results) do
    %{
      "results" => results,
      "count" => length(results),
      "page_info" => %{
        "after" => nil,
        "before" => nil,
        "has_next_page" => false,
        "has_prev_page" => false,
      }
    }
  end

  def open_api_bypass do
    bypass_for_configured_endpoint(:tychron_api, :default_endpoint_url)
  end

  def bypass_for_configured_endpoint(application_name, field) do
    value = Application.get_env(application_name, field)

    bypass_for_url(value)
  end

  def bypass_for_url(url) when is_binary(url) do
    case URI.new(url) do
      {:ok, uri} ->
        Bypass.open(port: uri.port)
    end
  end
end
