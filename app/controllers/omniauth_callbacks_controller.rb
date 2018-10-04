class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def stripe_connect
    hash = request.env["omniauth.auth"]
    email = hash.fetch('info').fetch('email')
    user = User.where(email: email).first
    stripe_user_attributes = {
        stripe_type: hash.provider,
        stripe_account_id: hash.uid,
        stripe_token: hash.credentials.token,
        stripe_key: hash.info.stripe_publishable_key
    }
    result = user.update_attributes(stripe_user_attributes)
    if result
      redirect_to root_path, notice: 'You have connected with Stripe successfully.'
    else
      redirect_to root_path, error: contact_support('There was an error connecting Stripe.')
    end
  end

  def stripe_disconnect
    @user = current_user
    nil_stripe_user = {stripe_type: nil, stripe_account_id: nil, stripe_token: nil, stripe_key: nil}
    result = @user.update_attributes!(nil_stripe_user)
    if result
      @notifications << 'Stripe disconnected successfully.'
    else
      @errors << 'There was an error disconnecting Stripe.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end