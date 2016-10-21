# FunTalk

## About

The Fun Talk App.

## Requirements

* Ruby 2.3+
* Rails 5.0+

## Deploy to Hosts Running CentOS

Install Ruby with RVM:

```shell
$ curl -L get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm
$ rvm install latest
```

Install Rails:

```shell
$ gem install rails
```

Install Passenger:

```bash
$ gem install passenger
```

Install Nginx:

```shell
$ rvmsudo passenger-install-nginx-module
```

Connect with Nginx:

```
server { 
	listen 80; 
	server_name example.com; 
	passenger_enabled on; 
	root /var/www/my_awesome_rails_app/public; 
}
```

And that's it!

## How to Test

:)