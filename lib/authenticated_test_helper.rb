module AuthenticatedTestHelper
  # Sets the current user in the session from the user fixtures.
  def login_as(user)
    @request.session[:user_id] = user ? users(user).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? ActionController::HttpAuthentication::Basic.encode_credentials(users(user).email, 'monkey') : nil
  end

  def create_user(options = {})
    if options[:email]
      record = User.new({ :email => "#{options[:email]}", :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    else
      record = User.new({ :email => "quire@quire69.com", :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    end

    record.register! if record.valid?
    record
  end

  def create_relationship_type(options = {})
    RelationshipType.create({ :name => 'Friend', :value => "friend" }.merge(options))
  end
  
  # rspec
  def mock_user
    user = mock_model(User, :id => 1,
      :email  => 'user@example.com',
      :name   => 'U. Surname',
      :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
      :errors => [])
    user
  end  
end
