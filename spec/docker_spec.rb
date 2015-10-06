describe Dockaswappa::Docker do
  let(:docker) { Dockaswappa::Docker.new 'busybox' }

  before do
    allow(docker).to receive(:docker_absolute_command_path) { 'docker' }
  end

  describe '#pull' do
    it 'returns the output if successful' do
      expect(docker).to receive(:`).with('docker pull busybox') { `echo 'test'`.strip }
      out = docker.pull
      expect(out).to eq "test"
    end

    it 'throws a PullFailed error if unsuccessful' do
      expect(docker).to receive(:`).with('docker pull busybox') { `false` }
      expect { docker.pull }.to raise_error(Dockaswappa::Error::PullFailed)
    end
  end

  describe '#ps' do
    it 'returns an array of the containers returned from docker ps' do
      expect(docker).to receive(:`).with('docker ps --filter name=app -q') { "12345\n67890" }
      containers = docker.ps
      expect(containers.map(&:id)).to eq ['12345', '67890']
    end
  end

  describe '#run' do
    it 'returns a container object of the newly ran container' do
      expect(docker).to receive(:`).with(/docker run/) { `echo '12345'`.strip }
      container = docker.run
      expect(container).to be_a_kind_of Dockaswappa::Container
      expect(container.id).to eq '12345'
    end

    it 'throws a RunFailed error if unsuccessful' do
      expect(docker).to receive(:`).with(/docker run/) { `false` }
      expect { docker.run }.to raise_error(Dockaswappa::Error::RunFailed)
    end
  end
end
