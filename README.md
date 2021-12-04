# Purpose
This app is for students to register as a member and apply for courses. 
Students can enroll classes and drop classes they have enrolled for. 
The admin can register all subjects and drop any subjects requested by any student.

## ERD
![ERD](../main/ERD.JPG)


## Gems used are Devise, OmniAuth, Pagenation, Faker and CarrierWave

### Devise for Sign in, Sign out and Sign up
Usage
`rails g devise:install`
`rails g devise user`
`rails db:migrate`
#### make views
rails g devise:views -v registrations confirmations sessions passwords

### OmniAuth for 3rd party authentication
`gem 'omniauth'`
`gem 'omniauth-facebook'`
`gem 'omniauth-github'`
`gem 'omniauth-google-oauth2'`
`gem 'activerecord-session_store'`
`gem 'omniauth-rails_csrf_protection'`

In shell, `EDITOR="code --wait" rails credentials:edit`
it will open up XXXX.credentails.yml file
Don't touch anything and just add
```
    google_client_id:
    google_client_secret:
    github_client_id:
    github_client_secret:
```

Then close the file then the file will be encrypted and saved

Config > initializers > divise.rb
```
 config.omniauth :facebook, Rails.application.credentials.dig(:facebook, :facebook_client_id),
 Rails.application.credentials.dig(:facebook, :facebook_client_secret), scope: 'public_profile,email'
 config.omniauth :github, Rails.application.credentials.dig(:github, :github_client_id),
 Rails.application.credentials.dig(:github, :github_client_secret), scope: 'user,public_repo'
 config.omniauth :google_oauth2, Rails.application.credentials.dig(:google, :google_client_id),
 Rails.application.credentials.dig(:google, :google_client_secret), scope: 'userinfo.email,userinfo.profile' 
```

 To activate activerecord-session_store
Make file config > initializers > session_store.rb
Type 
`Rails.application.config.session_store :active_record_store, key: '_devise-omniauth_session'`

rails g migration update_users
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

`rails db:drop`
`rails db:create`
`rails db:migrate`

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

in the controller
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
`gem kaminari`
`rails g kaminari:views bootstrap4`

in view 
```
<div class="container pagination justify-content-center" >
  <%= paginate @subjects %>
</div>
```

in controller 
```
  def index
    @subjects = Subject.all.page(params[:page]).per(3)
  end
```

### Faker for Fake data
in seed.rb
```
Faker::Lorem.paragraph(sentence_count: rand(7..10))
Faker::Name.unique.name.split(' ')
```

### CarrierWave for file and image upload
`gem 'carrierwave'`
`rails g uploader file`
`rails g uploader image`


in the model you want to handle image
```
class Subject < ApplicationRecord
    mount_uploader :image, ImageUploader
end
```

in the view
```
<%= form_for @teaching, html: { multipart:  true } do |f| %>
.....
<%= f.file_field :image %>
```

### Nested Form used(write 3 tables in one form)
Teachers   <-- Teaching --> Subjects
   M               1           M

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


## To be
More validation
RSpec Test
Student's Timetable
Teacher's Timetable







