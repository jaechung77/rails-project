# Purpose
This app is for students to register as a member and apply for courses.<br> 
Students can enroll classes and withdraw classes they have enrolled for.<br>  
The admin can register and drop subjects requested by students.<br> 

## ERD
![ERD](../main/ERD.JPG)


## Gems used: Devise, OmniAuth, Pagenation, Faker and CarrierWave

### Devise for Sign in, Sign out and Sign up
#### Installation
`gem 'omniauth'`<br> 
`rails g devise:install`<br>
#### Make User Model and Table, Migration<br> 
`rails g devise user`<br> 
`rails db:migrate`<br> 
#### make views
`rails g devise:views -v registrations confirmations sessions passwords`

### OmniAuth for 3rd party authentication
#### Installation for facebook, github and google
`gem 'omniauth'`<br> 
`gem 'omniauth-facebook'`<br> 
`gem 'omniauth-github'`<br> 
`gem 'omniauth-google-oauth2'`<br> 
`gem 'activerecord-session_store'`<br> 
`gem 'omniauth-rails_csrf_protection'`<br> 

#### Store id and secret in safe location
In shell, `EDITOR="code --wait" rails credentials:edit`
It will open up XXXX.credentails.yml file
Don't touch anything and just add
```
    google_client_id:
    google_client_secret:
    github_client_id:
    github_client_secret:
```

Then close the file then the file will be encrypted and saved<br>

config > initializers > divise.rb
```
 config.omniauth :facebook, Rails.application.credentials.dig(:facebook, :facebook_client_id),
 Rails.application.credentials.dig(:facebook, :facebook_client_secret), scope: 'public_profile,email'
 config.omniauth :github, Rails.application.credentials.dig(:github, :github_client_id),
 Rails.application.credentials.dig(:github, :github_client_secret), scope: 'user,public_repo'
 config.omniauth :google_oauth2, Rails.application.credentials.dig(:google, :google_client_id),
 Rails.application.credentials.dig(:google, :google_client_secret), scope: 'userinfo.email,userinfo.profile' 
```

To activate activerecord-session_store<br>
Make file config > initializers > session_store.rb
Type 
`Rails.application.config.session_store :active_record_store, key: '_devise-omniauth_session'`

`rails g migration update_users`
```
add_column(:users, :provider, :string, limit: 50, null: false, default: '')
add_column(:users, :uid, :string, limit: 500, null: false, default: '')
```

`rails g migration create_sessions`
```
t.string :session_id, null: false
t.text :data
```

outside create_table do block
```
add_index :sessions, :session_id, unique: true
add_index :sessions, :updated_at
```

`rails db:drop`<br>
`rails db:create`<br>
`rails db:migrate`<br>

User Model
```
:omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]
```

```
def self.create_from_provider_data(provider_data)
	where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
		user.email = provider_data.info.email
		user.password = Devise.friendly_token[0, 20]
	end	
end
```

`rails g controller omniauth`

In the controller
```
    def facebook
        @user = User.create_from_provider_data(request.env['omniauth.auth'])
        if @user.persisted?
            sign_in_and_redirect @user
            set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
        else
            flash[:error] = "There was a problem signing you in through facebook. Please register or try signing in later."
            redirect_to new_user_registration_url
        end
    end

    def github
        @user = User.create_from_provider_data(request.env['omniauth.auth'])
        if @user.persisted?
            sign_in_and_redirect @user
            set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
        else
            flash[:error] = "There was a problem signing you in through Github. Please register or try signing in later."
            redirect_to new_user_registration_url
        end
    end

    def google_oauth2
        @user = User.create_from_provider_data(request.env['omniauth.auth'])
        if @user.persisted?
            sign_in_and_redirect @user
            set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        else
            flash[:error] = "There was a problem signing you in through Google. Please register or try signing in later."
            redirect_to new_user_registration_url
        end
    end
	
	def failure
        flash[:error] = 'There was aproblem signing you in. Please register or try signing in later.'
        redirect_to new_user_registration_url
    end
```

Links from sign in page are from views>devise>shared>_links.html.erb	

Router
```
	devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
```

### Pagination for indexed page
`gem kaminari`<br>
`rails g kaminari:views bootstrap4`<br>

In view 
```
<div class="container pagination justify-content-center" >
  <%= paginate @subjects %>
</div>
```

In controller 
```
  def index
    @subjects = Subject.all.page(params[:page]).per(3)
  end
```

### Faker for Fake data
In seed.rb
```
Faker::Lorem.paragraph(sentence_count: rand(7..10))
Faker::Name.unique.name.split(' ')
```

### CarrierWave for file and image upload
`gem 'carrierwave'`<br>
`rails g uploader file`<br>
`rails g uploader image`<br>


In the model you want to handle image
```
class Subject < ApplicationRecord
    mount_uploader :image, ImageUploader
end
```

In the view
```
<%= form_for @teaching, html: { multipart:  true } do |f| %>
.....
<%= f.file_field :image %>
```

### Nested Form used(write 3 tables in one form)
Teachers(M)   <-- Teaching(1) --> Subjects(M)<br>

Models
```
class Teacher 
    has many :teachings
end

class Teaching 
    belongs_to :teacher
    belongs_to :subject
    accepts_nestedt_attributes_for :teacher
    accepts_nestedt_attributes_for :subject
end    

class Subject
    has_many :teachings
end
```

Controllers
```
def new
    @teaching = Teaching.new
    @teaching.build_teacher
    @teaching.build_subject
end

def teaching_params
    params.require(:teaching).permit(:teacher_attributes => [:first_name, :last_name, :major], :subject_attributes => [:name, :description, :image])
end
```

Views
```
    <%= f.fields_for :subject do |subject_builder| %>

    <%= f.fields_for :teacher do |teacher_builder| %>
```








