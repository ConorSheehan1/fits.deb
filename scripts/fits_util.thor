#!/usr/bin/env ruby
# frozen_string_literal: true

require "thor"

# Thor Commandline Utility for managing fits debian package
class FitsUtil < Thor
  class_option :debug, type: :boolean,
                       desc: "don't run commands if true, just print them"

  desc "build VERSION (default = 1.4.0)",
       "build the latest deb package for the given fits version"
  method_option :sign, type: :boolean, default: false, required: false,
                       desc: "sign changes using gpg key"
  method_option :createorig, type: :boolean, default: false, required: false,
                             desc: "remove old orig.tar and create new one"
  def build(version = "1.4.0")
    in_fits_dir(version) do
      create_orig if options["createorig"]
      debuild_args = options["sign"] ? "-S -sa" : "-us -uc"
      system_command(
        "sudo debuild #{debuild_args} --lintian-opts --profile debian"
      )
    end
  end

  desc "commit VERSION (default = 1.4.0)",
       "make patch file and changelog for latest changes"
  def commit(version = "1.4.0")
    in_fits_dir(version) do
      system_command("dpkg-source --commit")
      system_command("dch -i")
    end
  end

  desc "get_fits VERSION", "wget fits.zip from harvard. e.g. 1.4.0"
  def get_fits(version)
    unless version.match?(/^\d+\.\d+\.\d+$/) # e.g 1.4.0
      raise ArgumentError, "Invalid version number"
    end

    fits_upstream = "https://github.com/harvard-lts/fits/" \
                    "releases/download/#{version}/fits-#{version}"
    output_dir = File.absolute_path(
      File.join(__dir__, "..", "fits-#{version}")
    )
    system_command("wget '#{fits_upstream}' -O '#{output_dir}.zip'")
    system_command("unzip #{output_path} -d #{output_dir}")
  end

  desc "install PATCH_VERSION (default = latest)",
       "install version of fits e.g. 1.4.0-1"
  def install(version = "latest")
    deb_file = if version != "latest"
                 "#{__dir__}/../fits_#{version}-all.deb"
               else
                 Dir["#{__dir__}/../*.deb"].max
               end
    system_command("sudo apt install #{File.absolute_path(deb_file)}")
  end

  desc "uninstall", "uninstall ppa and fits"
  def uninstall
    system_command(
      "sudo add-apt-repository --remove ppa:conorsheehan1/fits-ppa"
    )
    system_command("sudo apt-get remove --purge fits")
  end

  desc "publish", "publish the latest changes"
  def publish
    latest_changes = File.absolute_path(
      Dir["#{__dir__}/../*_source.changes"].max
    )
    system_command("dput ppa:conorsheehan1/fits-ppa #{latest_changes}")
  end

  private

  # if the orig.tar exists, move it to .bak, unless that exists too
  # must be called in build!
  def create_orig
    origs = Dir["#{__dir__}/../fits_#{version}.orig.tar.*"]
    origs.each do |orig_file|
      orig_path = File.absolute_path(orig_file)
      bak_path = "#{orig_path}.bak"
      raise ArgumentError, "#{bak_path} already exists" if File.exist?(bak_path)

      system_command("mv #{orig_path} #{orig_path}.bak")
    end
    system_command("sudo dh_make --createorig --single --yes")
  end

  # @param [String] version
  def fits_dir(version)
    fits_src_dir = File.absolute_path("#{__dir__}/../fits-#{version}")
    err_msg = "Invalid version dir #{fits_src_dir}"
    raise ArgumentError, err_msg unless File.exist?(fits_src_dir)

    fits_src_dir
  end

  # @param [String] version
  def in_fits_dir(version, &_block)
    target_dir = fits_dir(version)
    puts("in dir: #{target_dir}")
    Dir.chdir(target_dir) do
      yield
    end
  end

  # @param [String] command
  def system_command(command)
    puts(command)
    system(command) unless options["debug"]
  end
end

FitsUtil.start(ARGV)
