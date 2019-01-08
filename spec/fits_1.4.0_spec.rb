require 'nokogiri'

describe "fits 1.4.0" do
  before do
    @images = %w[*.jpg *.png *.tiff].map do |ext|
      Dir["#{@fixture_path}/#{ext}"]
    end.flatten
    @text_files = %w[*.txt *.md].map do |ext|
      Dir["#{@fixture_path}/#{ext}"]
    end.flatten
  end
  after do
    Dir["#{@fixture_path}/output/*"].map do |f|
      File.delete(f)
    end
  end
  describe "version" do
    it "should display a valid version" do
      # TODO better way to test this, both output and capture fail
      expect(system("fits -version > #{@fixture_path}/output/fits.version")).to be true
      expect(File.read("#{@fixture_path}/output/fits.version")).to eq "1.4.0\n"
    end
  end
  describe "file classification" do
    before do
      @file = "example.png"
      @command = "fits -i #{@fixture_path}/#{@file} -o \
                  #{@fixture_path}/output/#{@file}.xml"
    end
    it "should write the classification to a valid xml file" do
      expect(system(@command)).to be true
      file = File.read("#{@fixture_path}/output/#{@file}.xml")
      xml = Nokogiri::XML(file)
      mimetype = xml.at('fits/identification/identity').attribute('mimetype').value
      expect(mimetype).to eq "image/png"

    end
  end
end
