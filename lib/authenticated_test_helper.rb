module AuthenticatedTestHelper
  # Sets the current user in the session from the user fixtures.
  def login_as(user)
    @request.session[:user_id] = user ? users(user).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? ActionController::HttpAuthentication::Basic.encode_credentials(users(user).login, 'monkey') : nil
  end

  def create_user(options = {})
    if options[:login]
      record = User.new({ :login => 'quire', :email => "#{options[:login]}@quire69.com", :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    else
      record = User.new({ :login => 'quire', :email => "quire@quire69.com", :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
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
      :login  => 'user_name',
      :name   => 'U. Surname',
      :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
      :errors => [])
    user
  end  
end
