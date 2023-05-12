defmodule Tychron.Config do
  def default_endpoint_url do
    Application.get_env(:tychron_api, :default_endpoint_url)
  end

  def default_auth_method do
    Application.get_env(:tychron_api, :default_auth_method)
  end

  def default_auth_identity do
    Application.get_env(:tychron_api, :default_auth_identity)
  end

  def default_auth_secret do
    Application.get_env(:tychron_api, :default_auth_secret)
  end
end
