just add: 

```ruby 
use Rack::Session::Cookie, secret: 'SECRET HERE'

use OmniAuth::Builder do 
  provider :facebook, 'APP ID HERE', 'APP SECRET HERE', {:provider_ignores_state => true}
end
```


and run ```rackup```