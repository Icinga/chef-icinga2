# Testing
## Prerequisites
We recommend to intall [ChefDK] to your development environment. 
It provides all tools used in the process of testig this cookbook.

Before starting, make sure you have installed all dependencies:

```shell
git clone https://github.com/Icinga/chef-icinga2.git
cd chef-icinga2
chef exec bundle install
```

## Integration 
### Requirements
* [Vagrant]
* [VirtualBox] (other Vagrant provider may work but are not tested)

### Run Tests
To run all test suits on all platforms:
```shell
kitchen test
```

Instead of running all integration tests, you can specify each suite and platform to create the instances. 
All steps can be run separately.
```
kitchen create server-ubuntu-1404
kitchen converge server-ubuntu-1404
kitchen setup server-ubuntu-1404
kitchen verify server-ubuntu-1404
kitchen destroy server-ubuntu-1404
```

List existing instances
```shell
kitchen list
```

## Spec
Unit tests are implemented in [ChefSpec]/[RSpec]:
```shell
chef exec rake spec
```

## Foodcritic
Linting is done with [Foodcritic]:
```shell
chef exec rake foodcritic
```

## Rubocop
Ruby code is analyzed with [Rubocop]:
```shell
chef exec rake rubocop
```

[ChefDK]: https://downloads.chef.io/chef-dk/
[Vagrant]: https://www.vagrantup.com/
[Virtualbox]: https://www.virtualbox.org/
[ChefSpec]: https://docs.chef.io/chefspec.html
[RSpec]: http://rspec.info/
[Foodcritic]: http://www.foodcritic.io/
[Rubocop]: https://github.com/bbatsov/rubocop