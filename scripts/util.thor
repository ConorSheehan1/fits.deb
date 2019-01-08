#!/usr/bin/env ruby
# frozen_string_literal: true

require "thor"

class Util < Thor
  desc "install PATCH_VERSION (default = latest)", 
       "install version of fits e.g. 1.4.0-1"
  def install(version = "latest")
    if version != "latest"
      system("sudo apt install #{__dir__}/../fits_#{version}-all.deb")
    else
      latest = Dir["#{__dir__}/../*.deb"].max
      system("sudo apt install #{File.absolute_path(latest)}")
    end
  end

  desc "build VERSION (default = 1.4.0)", 
       "build the latest version of fits"
  def build(version = "1.4.0")
    Dir.chdir("#{__dir__}/../fits-#{version}") do
      system("sudo dh_make --createorig --single --yes")
      system("sudo debuild -us -uc --lintian-opts --profile debian")
    end
  end

  desc "get_fits VERSION", "wget fits.zip from harvard. e.g. 1.4.0"
  def get_fits(version)
    version_regex = /^\d+\.\d+\.\d+$/  # e.g 1.4.0
    raise ArguementError, "Invalid version number" unless version.match version_regex
    fits_upstream = "https://github.com/harvard-lts/fits/" + 
                    "releases/download/#{version}/fits-#{version}"
    output_path = File.absolute_path(File.join(__dir__, "..", "fits-#{version}.zip"))
    system("wget '#{fits_upstream}' -O '#{output_path}'")
  end
end

Util.start(ARGV)
