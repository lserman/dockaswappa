describe Dockaswappa::Container do
  let(:container) { Dockaswappa::Container.new '12345' }

  describe '#stop' do
    it 'returns the container ID if successful' do
      expect(container).to receive(:`).with('docker stop 12345') { `true` }
      out = container.stop
      expect(out).to eq '12345'
    end

    it 'throws a StopFailed error if unsuccessful' do
      expect(container).to receive(:`).with('docker stop 12345') { `false` }
      expect { container.stop }.to raise_error(Dockaswappa::Error::StopFailed)
    end
  end

  describe '#up_on_port?' do
    before do
      expect(container).to receive(:port_mapping_to).with(80) { 80 }
    end

    it 'returns true when curl returns 200' do
      expect(container).to receive(:`).with(/curl/) do
        <<-CURL
        HTTP/1.1 200 OK
        Date: Tue, 29 Sep 2015 04:13:39 GMT
        CURL
      end
      expect(container).to be_up_on_port 80
    end

    it 'returns false when curl times out' do
      expect(container).to receive(:`).with(/curl/) do
        "curl: (6) Could not resolve host"
      end
      expect(container).to_not be_up_on_port 80
    end
  end
end
