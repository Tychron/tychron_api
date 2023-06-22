defmodule Tychron.Config do
  def default_api_endpoint_url do
    Application.get_env(:tychron_api, :default_api_endpoint_url)
  end

  def default_api_auth_method do
    Application.get_env(:tychron_api, :default_api_auth_method)
  end

  def default_api_auth_identity do
    Application.get_env(:tychron_api, :default_api_auth_identity)
  end

  def default_api_auth_secret do
    Application.get_env(:tychron_api, :default_api_auth_secret)
  end

  def default_sms_endpoint_url do
    Application.get_env(:tychron_api, :default_sms_endpoint_url)
  end

  def default_sms_auth_method do
    Application.get_env(:tychron_api, :default_sms_auth_method)
  end

  def default_sms_auth_identity do
    Application.get_env(:tychron_api, :default_sms_auth_identity)
  end

  def default_sms_auth_secret do
    Application.get_env(:tychron_api, :default_sms_auth_secret)
  end

  def default_mms_endpoint_url do
    Application.get_env(:tychron_api, :default_mms_endpoint_url)
  end

  def default_mms_auth_method do
    Application.get_env(:tychron_api, :default_mms_auth_method)
  end

  def default_mms_auth_identity do
    Application.get_env(:tychron_api, :default_mms_auth_identity)
  end

  def default_mms_auth_secret do
    Application.get_env(:tychron_api, :default_mms_auth_secret)
  end
end
