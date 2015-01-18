#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
{
  "run_list": [
    "ruby_build",
    "rbenv::user"
  ],
  "rbenv": {
    "user_installs": [
      {
        "user": "vagrant",
        "rubies": ["2.1.0"],
        "global": "2.1.0",
          "gems": {
            "2.1.0": [
              {"name": "bundler"}
            ]
          }
        }
      }
    ]
  }
}
