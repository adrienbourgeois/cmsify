# Cmsify

## Installion and mounting

Mount the api endpoints in your routes.rb file (with whichever namespace):

```ruby
Rails.application.routes.draw do
  mount Cmsify::Engine => "/cmsify"
end
```

## Whitelist (Work in progress)

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

### Advanced config

#### Edit a decorated field

The Shoe model has a "price_cents" field an a "currency" field (see the Money gem). We want to use the helper from the Money gem to display the formated price in our view:

```erb
  <p>
    <%=abc object: @shoe, field: :price, post_filer: [:format] %>
  </p>
```

```ruby
Cmsify.configure do |config|
  config.white = {
    Shoes => {
      price: {
        setter: Proc.new do |ar, raw_value|
          ar.price = raw_value.to_money
        end,

      }
    }
  }
end
```

#### Refine a decorated editable field into other editable fields

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

#### Advanced postfilters

```html
<h2>
  <%=abc object: @shoe, field: :name, post_filter: [:titleize, gsub: [/foo/,'bar']] %>
</h2>
```

## Generic placeholder

Install the migrations:

$ rake cmsify:install:migrations

and run them:

$ rake db:migrate


# Copyrights

This project rocks and uses MIT-LICENSE.