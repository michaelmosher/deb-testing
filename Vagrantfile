# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"

  config.vm.define "builder" do |builder|
    builder.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y build-essential bundler libsqlite3-dev nodejs ruby-dev sqlite3 yarn
    SHELL
  end

  config.vm.define "runner" do |runner|
    runner.vm.network "forwarded_port", guest: 80, host: 8080

    runner.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y bundler ruby nodejs sqlite3
    SHELL

    # provision unit here
  end
end
