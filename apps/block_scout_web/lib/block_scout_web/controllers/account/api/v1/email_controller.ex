defmodule BlockScoutWeb.Account.Api.V1.EmailController do
  use BlockScoutWeb, :controller

  action_fallback(BlockScoutWeb.Account.Api.V1.FallbackController)

  def resend_email(conn, _params) do
    with user <- get_session(conn, :current_user),
         {:auth, false} <- {:auth, is_nil(user)} do
      domain = Application.get_env(:ueberauth, Ueberauth.Strategy.Auth0.OAuth)[:domain]
      api_key = ""
      headers = [{"Authorization", "Bearer #{api_key}"}, {"Content-Type", "application/json"}]
      url = "https://#{domain}/api/v2/jobs/verification-email"

      body = %{
        "user_id" => user.uid
      }

      request = HTTPoison.post(url, Jason.encode!(body), headers, [])
    end
  end
end
