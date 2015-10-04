describe Dockaswappa::Poller do
  let(:poller) { Dockaswappa::Poller.new timeout: 5 }

  describe '#poll_until' do
    it 'polls block returns true' do
      counter = 0
      poller.poll_until do
        counter += 1
        counter == 3
      end
      expect(counter).to eq 3
    end

    it 'times out and raises a container timeout error' do
      expect {
        poller.poll_until { false }
      }.to raise_error(Dockaswappa::Error::ContainerTimeout)
    end
  end
end
