#!/usr/bin/env ruby
# frozen_string_literal: true

require "thor"

class Util < Thor
  class_option :debug, type: :boolean, 
                       desc: "don't run commands if true, just print them"

  desc "install PATCH_VERSION (default = latest)", 
       "install version of fits e.g. 1.4.0-1"
  def install(version = "latest")
    command = if version != "latest"
                "sudo apt install #{__dir__}/../fits_#{version}-all.deb"
              else
                latest = Dir["#{__dir__}/../*.deb"].max
                "sudo apt install #{File.absolute_path(latest)}"
              end
    system_command(command)
  end

  desc "build VERSION (default = 1.4.0)", 
       "build the latest deb package for the given fits version"
  method_option :sign, type: :boolean, default: false, required: false
  def build(version = "1.4.0")
    target_dir = fits_dir(version)
    puts("in dir: #{target_dir}")
    Dir.chdir(target_dir) do
      # create_orig
      debuild_args = options["sign"] ? "-S -sa" : "-us -uc"
      system_command("sudo debuild #{debuild_args} --lintian-opts --profile debian")
    end
  end

  desc "get_fits VERSION", "wget fits.zip from harvard. e.g. 1.4.0"
  def get_fits(version)
    version_regex = /^\d+\.\d+\.\d+$/  # e.g 1.4.0
    raise ArgumentError, "Invalid version number" unless version.match version_regex
    fits_upstream = "https://github.com/harvard-lts/fits/" + 
                    "releases/download/#{version}/fits-#{version}"
    output_path = File.absolute_path(File.join(__dir__, "..", "fits-#{version}.zip"))
    system_command("wget '#{fits_upstream}' -O '#{output_path}'")
  end

  desc "publish", "publish the latest changes"
  def publish
    latest_changes = File.absolute_path(Dir["#{__dir__}/../*_source.changes"].max)
    system_command("dput ppa:conorsheehan1/fits-ppa #{latest_changes}")
  end

  private

  # @param [String] version
  def fits_dir(version)
    fits_src_dir = File.absolute_path("#{__dir__}/../fits-#{version}")
    err_msg = "Invalid version dir #{fits_src_dir}"
    raise ArgumentError, err_msg unless File.exist?(fits_src_dir)
    fits_src_dir
  end

  def system_command(command)
    puts(command)
    system(command) unless options["debug"]
  end

  # must be called in build!
  def create_orig
    command = "sudo dh_make --createorig --single --yes"
    system_command(command)
  end

end

Util.start(ARGV)
