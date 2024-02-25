# README

This README provides instructions for setting up and running the application.

Things you may want to cover:
* System dependencies

This project is designed to be compatible with standard Oracle Linux 9.3 packages and repositories. We are committed to supporting the latest versions of Oracle Linux to the best of our ability. Any updates to the project will ensure compatibility with the newest releases of Oracle Linux.

While Oracle Linux is the recommended environment, you have the flexibility to use any Linux distribution according to your preferences.

* Ruby version `ruby 3.1.2p20`

* Bundle version `bundle-2.3.7`

* System configuration

System update and install needed instruments:
```shell
sudo dnf update
sudo dnf config-manager --enable ol9_codeready_builder
sudo dnf install git make gcc curl nano @ruby:3.1 ruby-devel libyaml-devel
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

Install project
```shell
git clone https://github.com/Kagayakashi/cloud_mu_online.git
cd cloud_mu_online/
bundle config set --local path 'vendor/bundle'
bin/bundle install
```

* Database creation

```shell
bin/rails db:create
```

* Database initialization

```shell
bin/rails db:migrate
```

* How to run the test suite

```
bin/rails test
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...