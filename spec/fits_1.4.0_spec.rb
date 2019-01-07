describe 'fits 1.4.0' do
  describe 'version' do
    after do
      File.delete('/tmp/fits.version')
    end
    it 'should display a valid version' do
      # TODO better way to test this, both output and capture fail
      expect(system('fits -version > /tmp/fits.version')).to be true
      expect(File.read('/tmp/fits.version')).to eq "1.4.0\n"
      # expect { system('fits -version') }.to output('1.4.0').to_stdout
      # output = capture(:stdout) { system('fits -version') }
      # expect(output).to eq("1.4.0\n")
    end
  end
end
