# frozen_string_literal: true

require "nokogiri"

describe "fits 1.4.0" do
  before do
    @images = fixtures_with_extensions(%w[*.jpg *.png *.tiff])
    @text_files = fixtures_with_extensions(%w[*.txt *.md])
  end
  after do
    Dir["#{@fixture_path}/output/*"].map do |f|
      File.delete(f)
    end
  end
  describe "version" do
    before do
      @output_file = "#{@fixture_path}/output/fits.version"
      @command = "fits -version > #{@output_file}"
    end
    it "should display a valid version" do
      # TODO: better way to test this, both output and capture fail
      expect(system(@command)).to be true
      expect(File.read(@output_file)).to eq "1.4.0\n"
    end
  end
  describe "file classification" do
    it_behaves_like "it can classify", "example.png", "image/png"
    it_behaves_like "it can classify", "example.jpg", "image/jpeg"
    it_behaves_like "it can classify", "example.tiff", "image/tiff"
    it_behaves_like "it can classify", "example.txt", "text/plain"
    it_behaves_like "it can classify", "README.md", "text/markdown"
  end
end
