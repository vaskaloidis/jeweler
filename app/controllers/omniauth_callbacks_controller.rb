class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    hash = request.env["omniauth.auth"]

    email = hash.fetch('info').fetch('email')

    user = User.where(email: email).first
    if user.update_attributes({
                                  stripe_type: hash.provider,
                                  stripe_account_id: hash.uid,
                                  stripe_token: hash.credentials.token,
                                  stripe_key: hash.info.stripe_publishable_key
                              })
    end

    redirect_to root_path, notice: 'You have connected with Stripe succesfully.'

  end

end