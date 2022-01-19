# -*- mode: ruby -*-
# vi: set ft=ruby :

nginx_unit_repo_config = <<EOF
deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ focal unit
deb-src [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/ubuntu/ focal unit
EOF

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"

  config.vm.define "builder" do |builder|
    builder.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y build-essential bundler libsqlite3-dev nodejs ruby-dev sqlite3 yarn
      cd /vagrant && make
    SHELL
  end

  config.vm.define "runner" do |runner|
    runner.vm.network "forwarded_port", guest: 80, host: 8080

    runner.vm.provision "shell", inline: <<-SHELL
      curl --output /usr/share/keyrings/nginx-keyring.gpg  \
        https://unit.nginx.org/keys/nginx-keyring.gpg

      echo "#{nginx_unit_repo_config}" > /etc/apt/sources.list.d/unit.list

      apt-get update
      apt-get install -y bundler nodejs ruby sqlite3 unit unit-ruby
      systemctl restart unit

      cd /vagrant && make install
      usermod -a -G rails unit

      curl -XPUT --data-binary @nginx-unit.json \
        --unix-socket /var/run/control.unit.sock http://localhost/config
    SHELL

    # provision unit here
  end
end
