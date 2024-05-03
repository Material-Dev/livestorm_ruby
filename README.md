Livestorm Ruby Client
=======================

A Ruby client for the [Livestorm API v1](https://github.com/Material-Dev/livestorm_ruby).


## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'livestorm_ruby'
```

Run `bundle install`.

## Usage

Use an access token obtained from [API Keys](https://app.livestorm.co/) on the Livestorm website after registration.

```ruby
client = LivestormApi.new(
  api_token: "1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1"
)
```


### Get Event People

Returns [event people](https://api.livestorm.co/v1/events/id/people).

```ruby
data = client.get_event_people(livestorm_event_id) # =>

#sample response =>
{
  data: [
    id: 'string',
    type: 'people',
    attributes: {
      "role"=>"team_member",
      "created_at"=>1616098251,
      "updated_at"=>1629059194,
      "timezone"=>"America/Los_Angeles",
      "first_name"=>"Stephen",
      "last_name"=>"Philp",
      "email"=>"sphilp@soapboxsample.com",
      "avatar_link"=>nil,
      "registrant_detail"=> {
        "event_id"=>"374d0ddb-5a47-4504-9fa3-1d70ab7fa5f7",
        "created_at"=>1629059133,
        "updated_at"=>1629059194,
        "fields"=> [
          { "id"=>"email", "type"=>"text", "value"=>nil, "required"=>true },
          { "id"=>"first_name", "type"=>"text", "value"=>nil, "required"=>true },
          { "id"=>"last_name", "type"=>"text", "value"=>nil, "required"=>true },
          { "id"=>"avatar", "type"=>"file", "value"=>nil, "required"=>false }
        ]
      }
    }
  ]
}
```


## Configuration

```ruby
# to use in a single file
require 'livestorm_api'

# to use globally
# create config/initializers/livestorm_ruby.rb and paste
require 'livestorm_api'
```

## Resources

* [Livestorm API Documentation](https://api.livestorm.co/v1)


## Copyright and License

Copyright (c) [2024] [harsh-materialplusio]

This project is licensed under the [MIT License](LICENSE.md).
