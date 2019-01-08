# frozen_string_literal: true

shared_examples "it can classify" do |file_name, expected_mimetype|
  before do
    @file_name = file_name
    @output_file = "#{@fixture_path}/output/#{@file_name}.xml"
    @command = "fits -i #{@fixture_path}/#{@file_name} -o #{@output_file}"
  end
  it "should classify #{file_name} as #{expected_mimetype}" do
    expect(system(@command)).to be true
    file = File.read(@output_file)
    xml = Nokogiri::XML(file)
    mimetype = xml.at("fits/identification/identity").attribute("mimetype")
    expect(mimetype.value).to eq expected_mimetype
  end
end
