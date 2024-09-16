# README

This README provides instructions for setting up and running the application.

Things you may want to cover:
* System dependencies

This project is designed to be compatible with standard Oracle Linux 9.3 packages and repositories. We are committed to supporting the latest versions of Oracle Linux to the best of our ability. Any updates to the project will ensure compatibility with the newest releases of Oracle Linux.

While Oracle Linux is the recommended environment, you have the flexibility to use any Linux distribution according to your preferences.

* Ruby version `ruby 3.3.4`

* Bundle version `bundle-2.5.11`

* System configuration

System update and install needed instruments:
```shell
sudo dnf update
sudo dnf config-manager --enable ol9_codeready_builder
sudo dnf install git make gcc curl nano ruby ruby-devel libyaml-devel
```

Install redis
```shell
sudo dnf install redis
sudo systemctl start redis
sudp systemctl enable redis
```

If used with WSL2, need to enable `systemd`:
```shell
sudo nano /etc/wsl.conf
```

Write there
```bash
[boot]
systemd=true
```

Install MySQL
```shell
sudo dnf install sqlite-devel mysql-server mysql-devel
sudo systemctl start mysqld
sudp systemctl enable mysqld
sudo mysql_secure_installation
```

Need to create MySQL user
```shell
mysql -u root -p
```
```sql
CREATE USER 'dbadmin'@'localhost' IDENTIFIED BY 'dbpassword';
GRANT ALL PRIVILEGES ON *.* TO 'dbadmin'@'localhost';
```

Configure ENV variables needed for: sidekiq, redis. Restart shell
```
export SIDEKIQ_USERNAME="admin"
export SIDEKIQ_PASSWORD="admin"
export REDIS_PORT="6379"
```

Install project
```shell
git clone https://github.com/Kagayakashi/cloud_mu_online.git
cd cloud_mu_online/
bundle config set --local path 'vendor/bundle'
bundle install
```

* Create project database

```shell
bin/rails db:create
```

* Install database migrations

```shell
bin/rails db:migrate
```

* Insert initial data into database

```shell
bin/rails db:seed
```

* How to run the application

```shell
bin/rails s
```

* How to run the test suite

```
bin/rails test
```

* Services (job queues, cache servers, search engines, etc.)
Start background job runner Sidekiq
```shell
bundle exec sidekiq
```

* ...
