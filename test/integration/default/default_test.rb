describe command 'which mcrouter' do
  its(:stdout) { should match(%r{/usr/bin/mcrouter}) }
end

%w(
  /etc/mcrouter
  /var/spool/mcrouter
  /var/log/mcrouter
).each do |dir|
  describe file dir do
    it { should be_directory }
    it { should be_owned_by 'mcrouter' }
    it { should be_grouped_into 'mcrouter' }
  end
end

describe file '/etc/mcrouter/mcrouter.json' do
  describe '#content' do
    subject { super().content }
    it do
      should(
        match(/\{\s+"pools": \{\s+"A": \{\s+"servers": \[\s+"localhost:11811"\s+\]\s+\}\s+\},\s+"route": "PoolRoute\|A"\s+\}/)
      )
    end
  end
end

describe service 'mcrouter' do
  it { should be_enabled }
  it { should be_running }
end
