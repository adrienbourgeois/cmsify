# Cmsify

This is a work in progress. Most of the functionalities haven't been implemented yet.

## Getting started

Add the gem to your gemfile:

```ruby
gem cmsify
```

```
$ bundle
```

Mount the api endpoints in your routes.rb file:

```ruby
Rails.application.routes.draw do
  mount Cmsify::Engine => "/cmsify"
end
```

Add the js and css dependencies to your manifests:

in your js manifest, add:

```js
//= require cmsify/dependencies/all
//= require cmsify/cmsify
```

in your css manifest, add:

```css
*= require cmsify/cmsify
```

Ideally you should load those css and js dependencies only for users with administration abilities (you don't want to load useless javascript for users who don't have administration rights).

(Note that for your convenience we've put all the dependencies in the manifest "cmsify/dependencies/all". Those dependencies include: angular, ng-upload-file, angular-xeditable. If your application already uses angular, please see: How to integrate cmsify with an existing angular application)

The last thing you need to do is to pass a procedure in the cmsify config to determine if a user has administration abilities. If you use devise/warden, this should look something like this (config/initializers/cmsify.rb):

```ruby
Cmsify.configure do |config|
  config.can_update = Proc.new do |request|
    current_user = request.env['warden'].user
    current_user.try(:has_role?, :content_admin)
  end
end
```

That's it! Now you can make any field of your rails models editable at a glance.

If you view looked something like this:

```html
<h1>Last article:</h1>
<p><%= Article.last.body %></p>
```

All you need to make that field editable is:

```html
<h1>Last article:</h1>
<p><%= abc object: Article.last, field: :body %></p>
```

and to whitelist that field by adding it to the list of editable fields in the cmsify config file:

```ruby
Cmsify.configure do |config|
  ...
  config.fields = {
    Article: {
      body: true
    }
  }
end
```

## Advanced config

```ruby
Cmsify.configure do |config|
  config.white = {
    Shoes => {
      model: true,
      price_cents: true,
      currency: true
    },
    Location => {
      street_address: true,
      city: true,
      postcode: true,
      country_code: true
    },
    ...
  }
end
```

### Edit a decorated field

The Shoe model has a "price_cents" field an a "currency" field which are used by a helper from the Money gem.

```html
  <p>price: <%= @shoe.price.format %></p>
```

To make that field editable, first let's create a helper that chains those two methods (you can create that within a decorator class, in a helper module or even in the model class itself):

```ruby
def formated_price
  self.price.format
end
```

```html
<p>price: <%=abc object: @shoe, field: :formated_price %></p>
```

and define a setter in your cmsify config:

```ruby
Cmsify.configure do |config|
  config.white = {
    Shoes => {
      formated_price: {
        setter: -> (ar, raw_value) { ar.price = raw_value.to_money }
        # raw_value.to_money will return a Money object and the setter :price= is defined by the money-rails gem
      }
    }
  }
end
```

To persist the modified content received by the api, cmsify calls the setter method defined for that field. If no setter method was defined, then the default one is called (if the field name is :title, the setter that will be called is :title=)


### Refine a decorated editable field into other editable fields

We have a decorator called '#full_address' on our Location model:

```ruby
def full_address
  "#{street_address}, #{city}, #{postcode}.<br>#{country_code}".html_safe
end
```

We can refine that field into editable fields:

```html
<p>Address:</p>
<p>
  <%=abc object: @shoe.location, field: :full_address do %>
    <%=abc object: @shoe.location, field: :street_address %>  
    <%=abc object: @shoe.location, field: :city %>  
    <%=abc object: @shoe.location, field: :postcode %>  
    <%=abc object: @shoe.location, field: :country_code %>  
  <% end %>
</p>
```

```ruby
Cmsify.configure do |config|
  config.white = {
    Location => {
      full_address: true,
      street_address: true,
      city: true,
      postcode: true,
      country_code: true
    }
  }
end
```

## Generic placeholder

Cmsify comes with generic models for text and images. That can be useful to make static content, that changes quite often, editable. As an example, let's image that your home page looks something like this:

```html
<h1>Red shoe on sales this week!</h1>
<p>blablabla</p>
```

That promo message has to change quite often but is not saved in any model. You can use the same :abc helper by providing a unique slug like so:

```html
<h1><%= abc slug: :promo_message_homepage %></h1>
<p>blablabla</p>
```

You can know easily edit that field. This will be saved in the Cmsify::Text model. All you need to do to use those generic models is to:

Install the migrations:

```
$ rake cmsify:install:migrations
```

and run them:

```
$ rake db:migrate
```

# Copyrights

This project rocks and uses MIT-LICENSE.