import Config

auth_secret = "0000000000000000000000000000000000000000000000000000000000000000"
config :tychron_api, [
  default_api_endpoint_url: "http://localhost:21111",
  default_api_auth_method: "bearer",
  default_api_auth_identity: "",
  default_api_auth_secret: auth_secret,

  default_mms_endpoint_url: "http://localhost:21112",
  default_mms_auth_method: "bearer",
  default_mms_auth_identity: "",
  default_mms_auth_secret: auth_secret,

  default_sms_endpoint_url: "http://localhost:21113",
  default_sms_auth_method: "bearer",
  default_sms_auth_identity: "",
  default_sms_auth_secret: auth_secret,
]
