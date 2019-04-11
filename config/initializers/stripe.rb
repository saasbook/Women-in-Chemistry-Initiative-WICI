Rails.configuration.stripe = {
    :publishable_key => Rails.application.secrets.stripe_publishable_key,
    :secret_key      => Rails.application.secrets.stripe_api_key
}

Stripe.api_key = Rails.application.secrets.stripe_api_key
