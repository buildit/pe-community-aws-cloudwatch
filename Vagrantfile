# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", 
                      path: "provision.sh",
                      env: {
                        AWS_REGION: ENV['AWS_REGION'],
                        DISCRIMINATOR: ENV['DISCRIMINATOR'],
                        NOTIFICATION_EMAIL: ENV['NOTIFICATION_EMAIL'],
                        AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
                        AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY']
                        }
end

