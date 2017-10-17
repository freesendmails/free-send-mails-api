module FirebaseHelper
  def firebase_users
    firebase_client.get('users_authenticated')
  end

  def firebase_find_users(email)
    if firebase_users && firebase_users.body.present?
      firebase_users.body.values.select {|u| u['email'] == email}
    end
  end

  def firebase_user_emails
    firebase_users.body.values.map {|u| u['email']} if firebase_users && firebase_users.body.present?
  end

  def add_confirmed_user_to_firebase(email, token=nil)
    user_params = {
      email: email,
      confirmated: true,
      created: Date.today,
      priority: 1,
      token: token || 'lmno1234'
    }
    firebase_client.push('users_authenticated', user_params)
    user_params
  end

  def add_unconfirmed_user_to_firebase(email, token=nil)
    user_params = {
      email: email,
      confirmated: false,
      created: Date.today,
      priority: 1,
      token: token || 'abcd9876'
    }
    firebase_client.push('users_authenticated', user_params)
    user_params
  end

  def firebase_client
    Firebase::Client.new(
      Rails.application.secrets.secret_url_fire_base,
      Rails.application.secrets.secret_key_fire_base
    )
  end
end
