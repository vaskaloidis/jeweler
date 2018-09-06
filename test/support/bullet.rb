bullet_enabled = false

if Bullet.enable?
  if bullet_enabled
  # if ENV['DISABLE_BULLET'].nil? || (!ENV['DISABLE_BULLET'].nil? && !ENV['DISABLE_BULLET'].true?)

    config.before(:each) do
      Bullet.start_request
    end

    config.after(:each) do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end

  end
end