# Day7



## 간단과제

### ASK 만들기

- ask 모델과 ask_controller를 만듭니다.

> ask모델의 column
>
> - ip_address
> - region
> - question

- `/ask` : 나에게 등록된 모든 질문을 출력
- `/ask/new` : 새로운 질문을 작성하는 곳
- `/ask/delete` : 질문을 삭제하는 곳
- `/ask/edit` : 질문을 수정

> 모델 만들고 route 설정하고 controller 작성하고 view파일 만들기

**routes.rb**

```ruby
Rails.application.routes.draw do
	...
  get '/ask' => 'ask#index'
  get '/ask/new' => 'ask#new'
  post '/ask/create' => 'ask#create'
  get '/ask/:id/delete' => 'ask#delete'
  get '/ask/:id/edit' => 'ask#edit'
  post '/ask/:id/update' => 'ask#update'
  get '/ask/show/:id' => 'ask#show'
  
end

```



**ask_controller.rb**

```ruby
class AskController < ApplicationController
    
    def index
       @asks = Ask.all
    end
    
    def show
        @ask = Ask.find(params[:id])
    end
    
    def new
    end
    
    def delete
        ask = Ask.find(params[:id])
        ask.destroy #DB의 데이터 삭제하는 명령어
        redirect_to "/ask"
    end
    
    def create
        ask = Ask.new
        ask.question = params[:q]
        ask.ip_address = request.ip #request를 통해 사용자의 정보를 가져올 수 있음. ip는 ip를 리턴.
        ask.region = request.location.region #user의 위치를 리턴
        ask.save
        redirect_to "/ask"
    end
    
    def edit
       @ask = Ask.find(params[:id])
    end
    
    def update
        ask = Ask.find(params[:id])
        ask.question = params[:q]
        ask.save
        redirect_to "/ask"
    end 
end
```



**20180615003810_create_asks.rb**

```ruby
class CreateAsks < ActiveRecord::Migration[5.0]
  def change
    create_table :asks do |t|
      t.text "question"
      t.string "ip_address"
      t.string "region"
      t.timestamps
    end
  end
end
```



**index.html.erb**

```ruby
    <div class="text-center">
        <a class="btn btn-primary" href="/ask/new">새 질문 등록하기</a>
    </div>
    <ul class="list-group">
        <% @asks.reverse.each do |ask| %>
        <li class="list-group-item">
            <%= ask.question %>
            <small>(<%=ask.ip_address%>,<%=ask.region%>)</small>
            <a href="/ask/show/<%= ask.id %>" class ="btn btn-secondary">보기</a>
            <a class="btn btn-success" href ="/ask/<%=ask.id%>/edit">수정</a>
            <a data-confirm="이 글을 삭제하시겠습니까?" class="btn btn-danger" href="/ask/<%=ask.id%>/delete">삭제</a></li>
        <% end %>
    </ul>
```



**new.html.erb**

```ruby
<form action="/ask/update" method="POST">
    <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
    <input class="form-control" type="text" name="q" placeholder="질문을 입력하세요">
    <input class="btn btn-success" type="submit" value="질문하기">
</form>
```



**edit.html.erb**

```ruby
<form action="/ask/<%=@ask.id%>/update" method="POST">
    <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
    <input class="form-control" type="text" name="q" value="<%= @ask.question %>">
    <input class="btn btn-success" type="submit" value="수정하기">
</form>
```



**show.html.erb**

```ruby
<div class="text-center">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page"><%= @ask.question%></li>
          </ol>
    </nav>
</div>
```



## CSS 및 Bootstrap 적용하기

**test_app > gemfile**

```css
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.1.1' # bootstrap-sass를 삭제하고 이것만 버전을 명시하여 입력한다.

gem 'geocoder' # Geocoder를 사용하기 위해입력
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
```



**test_app > app > assets > stylesheets > application.scss** 

- bundle install을 통해 gem file을 설치 후에 application.css를 application.scss로 확장명을 변경한다.

```ruby
@import "bootstrap"; #입력
```



**test_app > app > assets > javascripts > application.js**

```css
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper //이거랑
//= require bootstrap //이거 추가
//= require turbolinks
//= require_tree .
```



**views > layouts > application.html.erb**

- 페이지에 동일한 layout이 적용되어야 할 경우 application.html.erb파일에 css등을 적용시켜주면됨.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>TestApp</title>
    <%= csrf_meta_tags %>  <!--이거는 뭐임?-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 이거 뭐임?-->
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom box-shadow">
      <h5 class="my-0 mr-md-auto font-weight-normal">중대장에게 질문하기</h5>
      <nav class="my-2 my-md-0 mr-md-3">
        <a class="p-2 text-dark" href="/ask">홈으로</a>
        <a class="p-2 text-dark" href="/ask/new">질문하기</a>
      </nav>
</div>
    <div class="container"> <!--container는 양쪽에 bar를 만들어줌-->
      <%= yield %>
    </div>
  </body>
</html>
```



geo coder : http://www.rubygeocoder.com/



# 간단과제

- **Twitter** 처음부터 만들어보기
- Table(Model)명: board
- Controller명: TweetController
  - action: *index, show, new, edit, update, destroy
- View: index, show, new, edit
- Bootstrap 적용하기
- 작성한 사람의 IP주소 저장하기
